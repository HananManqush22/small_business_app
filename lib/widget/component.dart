import 'package:flutter/material.dart';

void navigateAndFinish({required context, required widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndReplacement({required context, required widget}) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });
