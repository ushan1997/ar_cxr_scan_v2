import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../title_bar.dart';
import 'disseas_identify_area_screen.dart';

enum AppState {
  free,
  picked,
  cropped,
}

class GetSubmittedImageScreen extends StatefulWidget {
  final String disease;
  final String image;
  const GetSubmittedImageScreen({
    Key? key,
    required this.disease,
    required this.image,
  }) : super(key: key);

  @override
  State<GetSubmittedImageScreen> createState() =>
      _GetSubmittedImageScreenState();
}

class _GetSubmittedImageScreenState extends State<GetSubmittedImageScreen> {
  File? selectedImage;
  String message = "";
  String _base64 = "";
  String disease = "Tuberculosis";
  bool isloading = false;
  late AppState state = AppState.free;
  String dbImage = "";

  @override
  void initState() {
    super.initState();
    (() async {
      setState(() {
        isloading = true;
      });
      try {
        if (mounted) {
          setState(() {
            _base64 = widget.image;
            disease = widget.disease;
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
    Uint8List bytes = base64Decode(_base64.replaceAll(RegExp(r'\s+'), ''));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: 'Disease Area Detect',
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          disease == "tb"
                              ? "Predicted Result is Tuberculosis"
                              : "Predicted Result is Lung Cancer",
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
                      dbImage == "" ? Image.memory(bytes) : Image.memory(bytes),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
        ]),
      ),
    );
  }
}
// Single child s
      
      
      
      
      
      
      
      
      
      
      
      
  

  