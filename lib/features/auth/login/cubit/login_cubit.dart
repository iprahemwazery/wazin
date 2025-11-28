import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      emit(LoginFailure("من فضلك ادخل الايميل والباسورد ❌"));
      return;
    }

    emit(LoginLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(LoginFailure("الإيميل غير مسجّل ❌"));
          break;
        case 'wrong-password':
          emit(LoginFailure("الباسورد غلط ❌"));
          break;
        case 'invalid-email':
          emit(LoginFailure("صيغة الايميل غلط ❌"));
          break;
        case 'network-request-failed':
          emit(LoginFailure("مشكلة في الإنترنت 📶"));
          break;
        default:
          emit(LoginFailure(e.message ?? "خطأ غير متوقع"));
      }
    } catch (e) {
      emit(LoginFailure("Error: $e"));
    }
  }
}
