import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_flutter_demo/helpers/pocket_base_helper.dart';
import 'package:pocketbase_flutter_demo/pages/auth/sign_up_page.dart';
import 'package:pocketbase_flutter_demo/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter demo"),
        ),
        body: const Center(
          child: Text("loading"),
        ),
      );
    }

    return StreamBuilder(
      stream: PocketBaseHelper().client.authStore.onChange,
      builder: (context, snapshot) {
        // if (snapshot.hasData) {
        //   SharedPreferences.getInstance().then((instance) {
        //     instance.setString('user', jsonEncode(snapshot.data?.model));
        //     instance.setString('token', jsonEncode(snapshot.data?.token));
        //   });

        //   PocketBaseHelper()
        //       .client
        //       .authStore
        //       .save(snapshot.data?.token ?? '', snapshot.data?.model);
        // }

        return PocketBaseHelper().client.authStore.isValid
            ? const MyHomePage(title: 'Flutter Demo Home Page')
            : const SignUpPage();
      },
    );
  }
}
