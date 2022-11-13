import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:pocketbase_flutter_demo/helpers/pocket_base_helper.dart';
import 'package:pocketbase_flutter_demo/localstorage/session.dart';
import 'package:pocketbase_flutter_demo/pages/home_page.dart';
import 'package:pocketbase_flutter_demo/pages/wrapper.dart';

void main() async {
  await dotenv.load();

  PocketBaseHelper().setPocketbaseUrl(dotenv.env['POCKETBASE_URL'] ?? "");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: 'Flutter Demo',
      home: const Wrapper(),
    );
  }
}
