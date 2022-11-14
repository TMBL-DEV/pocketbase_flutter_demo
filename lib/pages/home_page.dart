import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_flutter_demo/helpers/pocket_base_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserModel user = PocketBaseHelper().client.authStore.model;
  int _counter = 0;
  bool loading = true;
  late String documentId;

  @override
  void initState() {
    loading = true;
    super.initState();
    var record = PocketBaseHelper()
        .client
        .records
        .getList(
          'count',
          filter: "userId = '${PocketBaseHelper().client.authStore.model.id}'",
        )
        .then((value) {
      documentId = value.items.first.id;
      _counter = value.items.first.data['amount'];
      listenToChanges();
      setState(() {
        loading = false;
      });
    }).catchError((error) {
      var shit = true;
      setState(() {
        loading = false;
      });
    });
  }

  void listenToChanges() {
    PocketBaseHelper().client.realtime.subscribe("count/$documentId", (item) {
      setState(() {
        _counter = item.record?.data['amount'] ?? _counter;
      });
    });
  }

  void _incrementCounter() {
    PocketBaseHelper().client.records.update('count', documentId,
        body: {'amount': _counter++}).then(((value) {
      var sheesh = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder(
          // stream:
          //     PocketBaseHelper().client.realtime.subscribe(subscription, (e) {}),
          builder: (context, snapshot) {
            return const Center(
              child: Text("loading"),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
