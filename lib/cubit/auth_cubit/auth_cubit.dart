import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> signData(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'This email isn\'t found.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'Wrong password.'));
      } else {
        emit(LoginFailure(errorMessage: 'An unexpected error occurred.'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'There was an error.'));
    }
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      var auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'week password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email-already-existed'));
      } else {
        emit(RegisterFailure(errorMessage: 'un expected error'));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'un expected error'));
    }
  }
}
