// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'app_constants.dart';

final textFieldDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(width: 1, color: kSecondaryColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(width: 1, color: kBorderColor),
  ),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        width: 1,
      )),
);

Widget formSubmitButton(String text, void Function() onPressed) => SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: kButtonColor),
          onPressed: onPressed,
          child: Text(text)),
    );
