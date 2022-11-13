import 'package:ar_cxr_scan/screen/title_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CXRImageClassify extends StatefulWidget {
  const CXRImageClassify({Key? key}) : super(key: key);

  @override
  State<CXRImageClassify> createState() => _CXRImageClassifyState();
}

class _CXRImageClassifyState extends State<CXRImageClassify> {
  File? selectedImage;
  String message = "";

  uploadImage() async {
    try {
      final String jsonConfig =
          await rootBundle.loadString('assets/host_config.json');
      final jsonHostData = await json.decode(jsonConfig);
      print("########################### URL--->" +
          jsonHostData["cxr_classify_host"] +
          "#####################");
      final request = http.MultipartRequest(
          "POST", Uri.parse(jsonHostData["cxr_classify_host"] + "/predict"));

      final headers = {"Content-type": "multipart/form-data"};

      request.files.add(http.MultipartFile('file',
          selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
          filename: selectedImage!.path.split("/").last));

      request.headers.addAll(headers);
      final response = await request.send();
      print("body");
      http.Response res = await http.Response.fromStream(response);
      print("body" + res.body);
      message = res.body;
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Server Error")));
    }
  }

  Future getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: "CXR image classify",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage == null
                ? Text("Please pick a Image to upload")
                : Image.file(selectedImage!),
            TextButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: uploadImage,
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text(
                  "Predict Result",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            message != ""
                ? Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "Predicted Disease = " + message,
                      style: TextStyle(
                        color: Color.fromARGB(255, 192, 61, 61),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  )
                : Center(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
