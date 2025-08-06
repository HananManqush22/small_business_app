import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'fire_authentication_state.dart';

class FireAuthenticationCubit extends Cubit<FireAuthenticationState> {
  FireAuthenticationCubit() : super(FireAuthenticationInitial());
  static FireAuthenticationCubit get(context) => BlocProvider.of(context);
  String? singInEmail;
  String? singInPassword;
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  User? user = FirebaseAuth.instance.currentUser;
  String? email;
  String? password;
  FirebaseAuth auth = FirebaseAuth.instance;

  void singInUser() async {
    String message = '';
    try {
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
        final GoogleSignInAuthentication googlAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googlAuth.accessToken,
          idToken: googlAuth.idToken,
        );

        // Once signed in, return the UserCredential
        await auth.signInWithCredential(credential);
        emit(SingInGooglSuccessState());
      } else {
        print('================================================');
        print('plese check google account');
      }
    } catch (e) {
      emit(SingInGooglErrorState(error: e.toString()));
    }
  }

  void createUser() async {
    String message = '';
    try {
      emit(UserCreateLoadingState());
      await auth.createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      );
      emit(UserCreateSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        print(message);
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
        print(message);
      }
      // Fluttertoast.showToast(
      //   msg: message,
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.black54,
      //   textColor: Colors.white,
      //   fontSize: 14.0,
      //);
    } catch (e) {
      emit(UserCreateErrorState(error: e.toString()));
    }
  }

  void sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print('send email Verification');
    }
  }
}
