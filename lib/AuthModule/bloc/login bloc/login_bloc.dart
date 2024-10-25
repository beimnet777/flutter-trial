import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_event.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_state.dart';
import 'package:flutter_px/AuthModule/data%20provider/login_provider.dart';
import 'package:flutter_px/AuthModule/repository/login_repo.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

final LoginProvider loginProvider = LoginProvider();
final LoginRepository loginRepo = LoginRepository(loginProvider);

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_login);
  }

  _login(Login event, Emitter<LoginState> emit) async {
    emit(Logging());
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    try {
      final response = await loginRepo.login(event.data);
      final accessToken = response.data['access'];
      final refreshToken = response.data['refresh'];
      await _preferences.setString("access_token", accessToken);
      await _preferences.setString("refresh_token", refreshToken);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

      await _preferences.setString("user_id", decodedToken['user_id']);
      await _preferences.setString("profile_id", decodedToken['profile_id']);

      emit(Logged());
    } catch (error) {
      emit(LoggingFailed("Incorrect username or password"));
    }
  }
}
