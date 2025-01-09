import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:memmatch/core/network/client/api_client.dart';
import 'package:memmatch/core/network/repository/base_repository.dart';
import 'package:memmatch/core/network/service/base_api_service.dart';
import 'package:memmatch/modules/game/bloc/game_bloc.dart';
import 'package:memmatch/modules/home/bloc/home_bloc.dart';
import 'package:memmatch/modules/game/network/image_load_api.dart';
import 'package:memmatch/modules/game/respository/image_load_repository.dart';

import 'repositories/local_storage_repository.dart';

final getIt = GetIt.instance;

serviceLocator() {
  //Network
  getIt.registerSingleton<Dio>(DioClient.dio);

  getIt.registerSingleton<BaseApi>(BaseApi(getIt.get<Dio>()));
  getIt.registerSingleton<ImageLoadApi>(ImageLoadApi(getIt.get<Dio>()));

  getIt.registerSingleton<BaseRepository>(BaseRepository(getIt.get<BaseApi>()));
  getIt.registerSingleton<LocalStorageRepository>(LocalStorageRepository());

  getIt.registerSingleton<ImageLoadRepository>(
      ImageLoadRepository(getIt.get<ImageLoadApi>()));

  getIt.registerSingleton<HomeBloc>(HomeBloc(
    imageLoadRepository: getIt.get<ImageLoadRepository>(),
    storageRepository: getIt.get<LocalStorageRepository>(),
  ));
  getIt.registerSingleton<GameBloc>(
    GameBloc(
        imageLoadRepository: getIt.get<ImageLoadRepository>(),
        homeBloc: getIt.get<HomeBloc>()),
  );
}
