abstract class LoginState {}

class LoginInitial extends LoginState {}

class Logging extends LoginState {}

class Logged extends LoginState {}

class LoggingFailed extends LoginState {
  final String error;
  LoggingFailed(this.error);
}
