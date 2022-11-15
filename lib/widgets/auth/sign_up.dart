import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_flutter_demo/helpers/pocket_base_helper.dart';
import 'package:pocketbase_flutter_demo/services/auth_service.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  int? pincode = null;

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
                    text: 'Register',
                    style: TextStyle(fontSize: 29, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'pincode',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a pincode';
                    }

                    pincode = int.parse(value);

                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          pincode != null) {
                        UserModel result = await PocketBaseHelper().register(
                          email: email,
                          password: password,
                          passwordConfirm: password,
                        );

                        await AuthService().storeEmail(email);
                        await AuthService()
                            .storePassword(password, pincode ?? 0);

                        await PocketBaseHelper()
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
