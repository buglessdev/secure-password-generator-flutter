// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_password_generator_flutter/app_constants.dart';
import 'package:secure_password_generator_flutter/form_style.dart';
import 'package:secure_password_generator_flutter/text_styles.dart';
import 'package:secure_password_generator_flutter/ui_helpers.dart';
import 'package:secure_password_generator_flutter/core_helpers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Password Generator',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          // Added to make checkbox round outline similar as the border color
          unselectedWidgetColor: kBorderColor),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Checkbox state variables

  bool upperCaseIncluded = false;
  bool numberIncluded = false;
  bool symbolIncluded = false;
  String generatedPassword = '';

  String generatePassword() {
    // List to temporarily store the generated password.
    List<String> password = [];
    // Counter for tracking number of types selected by user
    int charTypes = 0;
    if (upperCaseIncluded) {
      password.add(Generate().generateUpper());
      charTypes = charTypes + 1;
    }

    if (numberIncluded) {
      password.add(Generate().generateNumber());
      charTypes = charTypes + 1;
    }
    if (symbolIncluded) {
      password.add(Generate().generateSymbol());
      charTypes = charTypes + 1;
    }

    // We have already generated [charTypes] characters, remaining characters
    // are added as lowercase characters.

    for (var i = 0; i < int.parse(controller.text) - charTypes; i++) {
      password.add(Generate().generateLower());
    }
    password.shuffle();
    // Convert the password array into a string.
    return password.join('');
  }

// Initial value of 8 given for the password length.
  TextEditingController controller = TextEditingController(text: '8');

  final _formKey = GlobalKey<FormState>();

// Builds text left to the form fields

  Widget _formFieldTextBuilder(String text) => Flexible(
      fit: FlexFit.tight,
      flex: 8,
      child: Text(
        text,
        style: bodyTextStyle,
      ));

// Builds the field where password is shown

  Widget _passwordOutputAreaBuilder() => Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: kBorderColor),
            borderRadius: BorderRadius.circular(10)),
        height: 55,
        child: Center(
          child: Text(
            generatedPassword,
            style: bodyTextStyle,
          ),
        ),
      );

  // Builds icon to copy

  Widget _copyIconBuilder() => IconButton(
      color: kSecondaryColor,
      onPressed: () {
        // Copy to clipboard functionality.
        Clipboard.setData(ClipboardData(text: generatedPassword));
      },
      icon: Icon(Icons.copy));

  // Builds the checkbox, the value and onChanged are the parameters.

  Widget _roundedCheckboxBuilder(
          bool isIncluded, void Function(bool?) onChanged) =>
      Flexible(
        flex: 1,
        child: Center(
          child: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: CircleBorder(),
              value: isIncluded,
              onChanged: onChanged,
            ),
          ),
        ),
      );

// Builds the form

  Form _formBuilder() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                _formFieldTextBuilder('Password Length'),
                Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        decoration: textFieldDecoration,
                        controller: controller,
                        validator: ((value) =>
                            value!.isEmpty ? 'Value required' : null),
                        style: TextStyle(color: Colors.white38),
                      ),
                    ))
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                _formFieldTextBuilder('Include Uppercase'),
                _roundedCheckboxBuilder(upperCaseIncluded, (v) {
                  setState(() {
                    upperCaseIncluded = v!;
                  });
                })
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                _formFieldTextBuilder('Include Numbers'),
                _roundedCheckboxBuilder(numberIncluded, (v) {
                  setState(() {
                    numberIncluded = v!;
                  });
                }),
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                _formFieldTextBuilder('Include Symbols'),
                _roundedCheckboxBuilder(symbolIncluded, (v) {
                  setState(() {
                    symbolIncluded = v!;
                  });
                })
              ],
            ),
            verticalSpaceLarge,
            formSubmitButton('Generate', () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  generatedPassword = generatePassword();
                });
              }
            })
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password Generator',
          style: heading1Style,
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Container(
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpaceLarge,
                verticalSpaceLarge,
                Row(
                  children: [
                    Expanded(child: _passwordOutputAreaBuilder()),
                    _copyIconBuilder()
                  ],
                ),
                verticalSpaceLarge,
                _formBuilder(),
                verticalSpaceXLarge
              ],
            ),
          ),
        ),
      ),
    );
  }
}
