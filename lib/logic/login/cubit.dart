import 'package:depi/logic/login/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit <LoginStates> {
  LoginCubit () : super (LoginInitialState());

  /// Function To Create Account For Users with firebase
  Future login ({
    required String email, required String pass
  }) async {
    emit(LoginLoadingState());
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      emit(LoginSuccessState());

    }catch(e){
      emit(LoginErrorState(em: e.toString()));
    }
  }
}