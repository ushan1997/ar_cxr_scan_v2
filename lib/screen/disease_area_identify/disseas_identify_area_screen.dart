import 'dart:convert';
import 'dart:typed_data';

import 'package:ar_cxr_scan/screen/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiseaseIdentifyAreaScreen extends StatefulWidget {
  final String resourse;
  final String? selectedDisease;
  const DiseaseIdentifyAreaScreen({
    Key? key,
    required this.resourse,
    required this.selectedDisease,
  }) : super(key: key);

  @override
  State<DiseaseIdentifyAreaScreen> createState() =>
      _DiseaseIdentifyAreaScreenState();
}

class _DiseaseIdentifyAreaScreenState extends State<DiseaseIdentifyAreaScreen> {
  String _base64 = "";
  bool isloading = false;
  String disease = "Tuberculosis";

  @override
  void initState() {
    super.initState();
    (() async {
      setState(() {
        isloading = true;
      });
      try {
        // final request = http.MultipartRequest(
        //     "POST", Uri.parse("http://127.0.0.1:5000/areadt/image"));
        // request.fields.addAll({"image_result": "tb", "clinical_result": "tb"});
        // final response = await request.send();
        // print("response");
        // print(response);
        // http.Response res = await http.Response.fromStream(response);
        // final resJson = jsonDecode(res.body);
        // String message = resJson["message"];
        // bool ststus = resJson["status"];
        // String resourse = resJson["resourse"];
        // print("resourse--->" + resourse);
        if (mounted) {
          setState(() {
            _base64 = widget.resourse;
            disease = widget.selectedDisease!;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Server Error")));
      }
      setState(() {
        isloading = false;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Uint8List bytes = base64Decode(_base64.replaceAll(RegExp(r'\s+'), ''));
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 143, 139, 139),
          title: const TitleBar(
            sectionName: 'Disease Area Detect',
          ),
        ),
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        disease + " Disease Area Identification",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.memory(bytes),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        disease == "Tuberculosis"
                            ? " This Patient can have Tuberculosis 94% and the spread area of diseases will be displayed in the above photo."
                            : "This Patient can have Lung Cancer 90% and the spread area of diseases will be displayed in the above photo.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Warning!: This application is not 100% accurate. Please get information from medical authorities...",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ],
                ),
              ),

        // const Text("Hi")
      );
    }
  }
}
