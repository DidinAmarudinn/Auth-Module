import 'package:auth_module/model/models.dart';
import 'package:auth_module/model/register_entry.dart';
import 'package:auth_module/service/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserAuthService.signIn(email, password);

    if (result.value != null) {
      emit(UserLoaded(result.value!));
    } else {
      emit(UserLoadingFailed(result.message!));
    }
  }

  Future<void> signUp(RegisterEntry registerEntry) async {
    ApiReturnValue<bool> result = await UserAuthService.signUp(registerEntry);

    if (result.value != null) {
      emit(RegisterLoaded(result.value!));
    } else {
      emit(RegisterFailed(result.message!));
    }
  }

  Future<void> forgotPass(String email, String newPass) async {
    ApiReturnValue<bool> result =
        await UserAuthService.forgotPasswor(email, newPass);

    if (result.value != null) {
      emit(ForgotPassLoaded(result.value!));
    } else {
      emit(ForgotPassFailed(result.message!));
    }
  }
}
