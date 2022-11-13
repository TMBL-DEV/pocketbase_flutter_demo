import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_flutter_demo/helpers/pocket_base_helper.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  @override
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(100, 100, 100, 100),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Login',
                    style: TextStyle(fontSize: 29, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(4),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    email = value;
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(4),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    password = value;

                    return null;
                  },
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        var user = await PocketBaseHelper()
                            .client
                            .users
                            .authViaEmail(email, password);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
