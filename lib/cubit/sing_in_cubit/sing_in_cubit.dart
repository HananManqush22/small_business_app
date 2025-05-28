import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'sing_in_state.dart';

class SingInCubit extends Cubit<SingInState> {
  SingInCubit() : super(SingInInitial());
  static SingInCubit get(context) => BlocProvider.of(context);

  String? singInEmail;
  String? singInPassword;
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  User? user = FirebaseAuth.instance.currentUser;

  void singInUser() async {
    String message = '';
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      emit(SingInLoadingState());
      await auth.signInWithEmailAndPassword(
        email: singInEmail!.trim(),
        password: singInPassword!.trim(),
      );

      if (user != null && !user!.emailVerified) {
        await user!.sendEmailVerification();
      } else {
        print('------------------------------------------------');
        print('check your email');
      }
      emit(SingInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        print(message);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        print(message);
      }
     
    } catch (e) {
      emit(SingInErrorState(error: e.toString()));
    }
  }

  void signInWithGoogle() async {
    try {
      emit(SingInGooglLoadingState());
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(SingInGooglSuccessState());
      } else {
        print('================================================');
        print('plese check google acount');
      }
    } catch (e) {
      emit(SingInGooglErrorState(error: e.toString()));
    }
  }


}
