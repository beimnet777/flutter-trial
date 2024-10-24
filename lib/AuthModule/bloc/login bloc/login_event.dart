abstract class LoginEvent {}

class Login extends LoginEvent {
  final Map<String, dynamic> data;

  Login(this.data);
}
