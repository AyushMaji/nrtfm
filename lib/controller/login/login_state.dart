part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.login(String uid, String uname) = _Login;
  const factory LoginState.logout() = _Logout;
}
