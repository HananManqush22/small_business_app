import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_create_state.dart';

class UserCreateCubit extends Cubit<UserCreateState> {
  UserCreateCubit() : super(UserCreateInitial());
  static UserCreateCubit get(context) => BlocProvider.of(context);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  void createUser() async {
    String message = '';
    try {
      emit(UserCreateLoadingState());
      await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
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
