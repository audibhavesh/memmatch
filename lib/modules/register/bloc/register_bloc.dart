import 'package:bloc/bloc.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/core/repositories/local_storage_repository.dart';
import 'package:memmatch/modules/register/bloc/register_state.dart';
import 'package:memmatch/modules/register/models/avatar.dart';
import 'package:memmatch/modules/register/repository/register_repository.dart';

import '../../../core/constants/app_constants.dart';

class RegisterBloc extends Cubit<AppState> {
  RegisterRepository registerRepository;
  LocalStorageRepository localStorageRepository;

  RegisterBloc(
      {required this.registerRepository, required this.localStorageRepository})
      : super(RegisterInitialState());

  Future<void> getAvatarImages() async {
    emit(AvatarImageLoading());
    try {
      final images = await registerRepository.getAvatarImages();
      emit(AvatarImageLoaded(images ?? []));
    } catch (e) {
      print(e);
      emit(RegisterError('Failed to load images'));
    }
  }

  void addNameAndAvatar(
      {required String name,
      required int selectedIndex,
      required List<Avatar> avatars}) async {
    try {
      emit(SavingUserDetails());
      await localStorageRepository.save(AppConstants.USERNAME, name);
      await localStorageRepository.save(AppConstants.AVATAR, selectedIndex);
      var imagePath = await registerRepository.downloadAndSaveAvatar(
          avatars[selectedIndex].imageUrl, selectedIndex);
      await localStorageRepository.save(AppConstants.AVATAR_PATH, imagePath);
      emit(UserDetailsSaved());
    } catch (e) {
      print(e);
      emit(RegisterError('Failed to save details'));
    }
  }

  Future<void> loadUserDetails() async {
    try {
      emit(LoadUserDetails());
      var userNameResponse = await localStorageRepository.getDocument(
        AppConstants.USERNAME,
      );
      var selectedAvatarResponse =
          await localStorageRepository.getDocument(AppConstants.AVATAR);

      var avatarImage =
          await localStorageRepository.getDocument(AppConstants.AVATAR_PATH);

      if (userNameResponse.payload["data"] != null &&
          selectedAvatarResponse.payload["data"] != null &&
          avatarImage.payload["data"] != null) {
        emit(UserDetailsLoaded(
            userNameResponse.payload["data"],
            selectedAvatarResponse.payload["data"],
            avatarImage.payload["data"]));
      }
    } catch (e) {
      print(e);
      emit(RegisterError('Failed to save details'));
    }
  }
}
