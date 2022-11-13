import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../title_bar.dart';

class LinkConfigure extends StatefulWidget {
  const LinkConfigure({Key? key}) : super(key: key);

  @override
  State<LinkConfigure> createState() => _LinkConfigureState();
}

class _LinkConfigureState extends State<LinkConfigure> {
   final linkController = TextEditingController();
   String link = "";

  Future configureLink() async {
   final String jsonConfig =
        await rootBundle.loadString('assets/host_config.json');
        final jsonHostData = await json.decode(jsonConfig);
        print(linkController.text);
    link=    jsonHostData["areadt_host"];
     jsonHostData["areadt_host"]=linkController.text;
      print(jsonHostData["areadt_host"]);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
     return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: 'AR for X-Ray',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Text('Important rate for Symptoms between 0-9',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Roboto',
                            color: Color(0xFFF44336),
                          )),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: linkController,
                        onChanged: (String value) {},
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Age",
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                       const SizedBox(
                        height: 30,
                      ),
                       link != ""
                       ? Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      link,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  )
                : Center(),
                      TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          configureLink();
                          //   Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (context) => DiseaseIdentifyAreaScreen(
                          //           resourse: "",selectedDisease: selectedDisease
                          //         )));
                        },
                        icon: const Icon(
                          Icons.upload_file,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ]
                  )
      ),
      ),
    );
    
  }
  

}