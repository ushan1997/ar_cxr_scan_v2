import 'package:flutter/material.dart';

import '../models/med.dart';
import '../services/medapi.dart';
import 'addmedrecform.dart';
import 'viewmedrecord.dart';

class medstore extends StatefulWidget {
  const medstore({Key? key}) : super(key: key);

  @override
  State<medstore> createState() => _medstoreState();
}

class _medstoreState extends State<medstore> {
  List<Med>? meds;
  var isLoaded = false;

  @override
  void initState() {
    getRecord();
  }

  getRecord() async {
    meds = await medapi().getAllrecords();
    if (meds != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> showMessageDialog(String title, String msg) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(
              msg,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical Details Store"),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(meds![index].drugName),
                subtitle: Text(meds![index].conditionName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        viewmedrecord(meds![index])))
                            .then((data) {});
                      },
                      icon: const Icon(Icons.view_agenda),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const addmedrecform())).then((data) {
            if (data != null) {
              showMessageDialog(
                  "Success", data.toString() + " details successfully added");
              getRecord();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
