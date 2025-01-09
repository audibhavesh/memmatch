import 'package:dio/dio.dart';
import 'package:memmatch/core/exceptions/api_exceptions.dart';
import 'package:memmatch/core/exceptions/app_exception.dart';

Future<T> handleApiRequest<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } on AppException catch (e) {
    rethrow;
  } on DioException catch (e) {
    print("DDDDD### $e");
    final apiException = ApiException.dioException(error: e,);
    throw apiException.appException();
  } catch (e) {
    throw ApiException.otherException(otherException: e).appException();
  }
}