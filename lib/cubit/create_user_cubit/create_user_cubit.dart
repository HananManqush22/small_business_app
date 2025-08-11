import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit() : super(CreateUserInitial());
  static CreateUserCubit get(context) => BlocProvider.of(context);

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  singInUser({required String email, required String password}) async {
    String message = '';
    try {
      if (user!.emailVerified) {
        emit(SingInLoadingState());
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await sendEmailVerification();
      }

      emit(SingInSuccessState());
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException code: ${e.code}');
      print('FirebaseAuthException message: ${e.message}');

      if (e.code == 'user-not-found') {
        print('..................................');
        print('No user found for that email.');
        print(message);
      } else if (e.code == 'wrong-password') {
        print('..................................');
        print('Wrong password provided for that user.');
        print(message);
      } else if (e.code == 'invalid-credential') {
        print('Invalid credentials. Please check your email and password.');
      }
      emit(SingInErrorState(error: e.message ?? 'Unknown error'));
    } catch (e) {
      emit(SingInErrorState(error: e.toString()));
    }
  }

  signInWithGoogle() async {
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

  createUser({required String email, required String password}) async {
    String message = '';
    try {
      emit(UserCreateLoadingState());
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
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

  DateTime? lastEmailSentTime; // نخزن آخر وقت إرسال

  sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;

    // التحقق من وجود مستخدم
    if (user != null && !user.emailVerified) {
      // إذا تم الإرسال سابقًا
      if (lastEmailSentTime != null) {
        final difference = DateTime.now().difference(lastEmailSentTime!);

        if (difference.inSeconds < 60) {
          print(
              'يجب الانتظار ${60 - difference.inSeconds} ثانية قبل إعادة الإرسال.');
          return;
        }
      }

      // إرسال البريد
      await user.sendEmailVerification();
      print(
          '  تم إرسال رابط التفعيل، قد يستغرق وصوله عدة دقائق، يرجى التحقق من البريد المزعج (Spam)');

      // حفظ وقت الإرسال الحالي
      lastEmailSentTime = DateTime.now();
    }
  }
}
