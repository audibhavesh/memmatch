import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/modules/register/models/avatar.dart';

class RegisterInitialState extends AppState {}

class AvatarImageLoading extends AppState {}

class AvatarImageLoaded extends AppState {
  final List<Avatar> avatars;

  AvatarImageLoaded(this.avatars);

  @override
  List<Object> get props => [avatars];
}

class RegisterError extends AppState {
  final String message;

  RegisterError(this.message);

  @override
  List<Object> get props => [message];
}

class SavingUserDetails extends AppState {}

class UserDetailsSaved extends AppState {}

class LoadUserDetails extends AppState {}

class UserDetailsLoaded extends AppState {
  final String username;
  final int selectedIndex;

  UserDetailsLoaded(this.username, this.selectedIndex);

  @override
  List<Object> get props => [username, selectedIndex];
}
