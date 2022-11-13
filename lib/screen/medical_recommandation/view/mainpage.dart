import 'package:flutter/material.dart';

import '../../title_bar.dart';
import 'addmedrecform.dart';
import 'filtercondition.dart';
import 'filterdrug.dart';
import 'reccomendation.dart';

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: "Medical Reccommendation System",
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(25),
            child: TextButton(
              child: Text(
                'Support Page',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecommandationScreen()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: TextButton(
              child: Text(
                'Search by condition',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FilterconditionPage()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: TextButton(
              child: Text(
                'Search by drug name',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FilterdrugPage()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: TextButton(
              child: Text(
                'Add New Details',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const addmedrecform()));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
