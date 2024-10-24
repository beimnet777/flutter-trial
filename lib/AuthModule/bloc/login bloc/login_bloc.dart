import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_event.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_state.dart';
import 'package:flutter_px/AuthModule/data%20provider/login_provider.dart';
import 'package:flutter_px/AuthModule/repository/login_repo.dart';

final LoginProvider loginProvider = LoginProvider();
final LoginRepository loginRepo = LoginRepository(loginProvider);

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_login);
  }

  _login(Login event, Emitter<LoginState> emit) async {
    emit(Logging());
    try {
      final response = loginRepo.login(event.data);
      emit(Logged());
    } catch (error) {
      emit(LoggingFailed("Incorrect username or password"));
    }
  }
}
