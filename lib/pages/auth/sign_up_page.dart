import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_flutter_demo/helpers/pocket_base_helper.dart';
import 'package:pocketbase_flutter_demo/widgets/auth/sign_in.dart';
import 'package:pocketbase_flutter_demo/widgets/auth/sign_up.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() {
    return SignUpPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class SignUpPageState extends State<SignUpPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<RegisterFormState>.
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  int _currentPage = 1;
  List screens = [
    SignUpWidget(key: UniqueKey()),
    SignInWidget(key: UniqueKey()),
  ];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text("sing up"),
      ),
      body: screens[_currentPage],
    );
  }
}
