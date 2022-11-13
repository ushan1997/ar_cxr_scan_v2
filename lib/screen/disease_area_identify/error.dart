import 'package:ar_cxr_scan/screen/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: 'Error',
        ),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "  Error",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}