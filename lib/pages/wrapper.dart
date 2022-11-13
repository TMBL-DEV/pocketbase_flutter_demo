import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pocketbase_flutter_demo/helpers/pocket_base_helper.dart';
import 'package:pocketbase_flutter_demo/localstorage/session.dart';
import 'package:pocketbase_flutter_demo/pages/auth/sign_up_page.dart';
import 'package:pocketbase_flutter_demo/pages/home_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    Isar.open([SessionSchema]).then((value) {
      value.sessions.filter().tokenIsNotNull().findAll().then((value) {
        if (value.isNotEmpty) {
          var item = value.first;
          PocketBaseHelper()
              .client
              .authStore
              .save(item.token ?? "nope", item.user);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
// PocketBaseHelper().client.users.

    return StreamBuilder(
      stream: PocketBaseHelper().client.authStore.onChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          PocketBaseHelper()
              .client
              .authStore
              .save(snapshot.data?.token ?? '', snapshot.data?.model);
        }
        return snapshot.hasData
            ? const MyHomePage(title: 'Flutter Demo Home Page')
            : const SignUpPage();
      },
    );
  }
}
