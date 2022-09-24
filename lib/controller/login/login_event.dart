part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.login() = Login;
  const factory LoginEvent.logout() = Logout;
}