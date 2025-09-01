import 'package:depi/logic/sign_up/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit <SignUpStates> {
  SignUpCubit () : super (SignUpInitialState());

  /// Function To Create Account For Users with firebase
    Future signUp ({
    required String email, required String pass
}) async {
      emit(SignUpLoadingState());
      try {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
        emit(SignUpSuccessState());

      }catch(e){
        emit(SignUpErrorState(em: e.toString()));
      }
    }
}