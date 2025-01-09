import 'dart:collection';

import 'package:memmatch/core/constants/app_constants.dart';
import 'package:memmatch/core/exceptions/app_exception.dart';
import 'package:memmatch/core/models/local_db_response.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/web.dart';

class LocalStorageRepository {
  late Box databaseReference;
  Logger logger = Logger();
  String? databaseName = AppConstants.localDBName;

  LocalStorageRepository({String? databaseName}) {
    this.databaseName = databaseName ?? AppConstants.localDBName;
    initializeDB();
  }

  initializeDB() async {
    try {
      if (databaseName != null && databaseName != "") {
        if (!Hive.isBoxOpen(databaseName ?? AppConstants.localDBName)) {
          await Hive.openBox(databaseName ?? AppConstants.localDBName);
        }
        databaseReference = Hive.box(databaseName ?? AppConstants.localDBName);
      }
    } catch (e) {
      logger.d(e.toString());
      throw AppException(AppResponseType.failed, "Failed to initialize db",
          extra: e);
    }
  }

  bool isStorageReady() {
    return databaseReference.isOpen;
  }

  Future<bool> isDocExists(String docId) async {
    await initializeDB();
    return databaseReference.containsKey(docId);
  }

  Future<LocalDBResponse> save(String key, dynamic data) async {
    try {
      await initializeDB();
      if (isStorageReady()) {
        await databaseReference.put(key, data);
        return LocalDBResponse(
            type: AppResponseType.success, message: "stored successfully.");
      } else {
        return LocalDBResponse(
            type: AppResponseType.failed,
            message: "unable to access database.");
      }
    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      print(e);
      throw AppException(AppResponseType.failed, "Failure while saving data",
          extra: e);
    }
  }

  Future<LocalDBResponse> getDocument(String key) async {
    try {
      await initializeDB();
      if (isStorageReady()) {
        dynamic data = await databaseReference.get(key);
        if (data is LinkedHashMap<dynamic, dynamic>) {
          data = Map<String, dynamic>.from(
              data); // Convert to Map<String, dynamic>
        }
        return LocalDBResponse(
            type: AppResponseType.success,
            message: "retrieved successfully.",
            payload: {"data": data});
      } else {
        return LocalDBResponse(
            type: AppResponseType.failed,
            message: "unable to access database.");
      }
    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      throw AppException(AppResponseType.failed, "Failure while getting data",
          extra: e);
    }
  }

  Future<LocalDBResponse> removeDocument(String key) async {
    try {
      await initializeDB();
      if (isStorageReady()) {
        await databaseReference.delete(key);
        return LocalDBResponse(
            type: AppResponseType.success,
            message: "deleted successfully.",
            payload: null);
      } else {
        return LocalDBResponse(
            type: AppResponseType.failed,
            message: "unable to access database.");
      }
    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      print(e);
      throw AppException(AppResponseType.failed, "Failure while getting data",
          extra: e);
    }
  }

  // New method to clear the database
  Future<LocalDBResponse> clearDB() async {
    try {
      await initializeDB();
      if (isStorageReady()) {
        await databaseReference.clear();
        return LocalDBResponse(
            type: AppResponseType.success,
            message: "Database cleared successfully.");
      } else {
        return LocalDBResponse(
            type: AppResponseType.failed,
            message: "Unable to access database.");
      }
    } catch (e) {
      logger.d(e.toString());
      throw AppException(
          AppResponseType.failed, "Failure while clearing database",
          extra: e);
    }
  }
}
