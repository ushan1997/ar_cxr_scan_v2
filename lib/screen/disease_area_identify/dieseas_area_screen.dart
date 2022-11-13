import 'dart:convert';
import 'dart:io';
import 'package:ar_cxr_scan/screen/disease_area_identify/get_submited_image.dart';
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
  process,
}

class DiseaseAreaScreen extends StatefulWidget {
  final String link;
  const DiseaseAreaScreen({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  State<DiseaseAreaScreen> createState() => _DiseaseAreaScreenState();
}

class _DiseaseAreaScreenState extends State<DiseaseAreaScreen> {
  String passLink = "";
  File? selectedImage;
  bool isloading = false;
  String dropdownValue = 'One';
  List<String> diseaseList = ["Tuberculosis", "Lung Cancer"];
  String? selectedDisease = "Tuberculosis";
  String message = "";
  late AppState state = AppState.free;

  @override
  void initState() {
    super.initState();
    setState(() {
      state = AppState.free;
    });
    (() async {
      setState(() {
        isloading = true;
      });
      if (mounted) {
        setState(() {
          passLink = widget.link;
        });
      }
      setState(() {
        isloading = false;
      });
    })();
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickImage = await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = File(pickImage!.path);
    setState(() {});
  }

  Future uploadImage(context) async {
    print(passLink);
    if (selectedImage != null) {
      try {
        setState(() {
          isloading = true;
        });
        setState(() {
          state = AppState.process;
        });

        final String jsonConfig =
            await rootBundle.loadString('assets/host_config.json');
        final jsonHostData = await json.decode(jsonConfig);
        print("############################### URL --->" +
            jsonHostData["areadt_host"] +
            "#####################");

        final http.MultipartRequest request;
        if (passLink == "") {
          request = http.MultipartRequest("POST",
              Uri.parse(jsonHostData["areadt_host"] + "/areadt/processimage"));
        } else {
          request = http.MultipartRequest(
              "POST", Uri.parse(passLink + "/areadt/processimage"));
        }
        final headers = {"Content-type": "multipart/form-data"};
        request.files.add(http.MultipartFile(
            'file',
            selectedImage!.readAsBytes().asStream(),
            selectedImage!.lengthSync(),
            filename: selectedImage!.path.split("/").last));

        request.headers.addAll(headers);
        if (selectedDisease == "Tuberculosis") {
          request.fields
              .addAll({"image_result": "tb", "clinical_result": "tb"});
        } else {
          request.fields
              .addAll({"image_result": "tb", "clinical_result": "tb"});
        }
        final response = await request.send();
        http.Response res = await http.Response.fromStream(response);
        final resJson = jsonDecode(res.body);
        String message = resJson["message"];
        String resourse = resJson["resourse"];
        if (resJson["code"] == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DiseaseIdentifyAreaScreen(
                      resourse: resourse, selectedDisease: selectedDisease)));
        }
        setState(() {
          isloading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Server Error")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Insert Valid Image")));
    }
  }

  Future reDirectUserImage(context) async {
    final String jsonConfig =
        await rootBundle.loadString('assets/host_config.json');
    final jsonHostData = await json.decode(jsonConfig);
    print("############################### URL --->" +
        jsonHostData["areadt_host"] +
        "#####################");
    Uri url;
    if (passLink == "") {
      url = Uri.parse(jsonHostData["areadt_host"] + "/areadt/getimage");
    } else {
      url = Uri.parse(passLink + "/areadt/getimage");
    }
    var response = await http.get(url);
    Map data = jsonDecode(response.body);
    String disease = data["disease"];
    String image = data["image"];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GetSubmittedImageScreen(disease: disease, image: image)));
  }

  @override
  Widget build(BuildContext context) {
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
                          "Insert X-Ray Image *",
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
                      selectedImage == null
                          ? Image.asset(
                              'assets/img_upload.png',
                              width: 200,
                              height: 300,
                            )
                          : Image.file(selectedImage!),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 240,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                          )),
                          value: selectedDisease,
                          icon: const Icon(Icons.arrow_downward),
                          style: const TextStyle(color: Colors.black),
                          items: diseaseList
                              .map((disease) => DropdownMenuItem<String>(
                                  value: disease,
                                  child: Text(
                                    disease,
                                    style: const TextStyle(fontSize: 20),
                                  )))
                              .toList(),
                          onChanged: (disease) =>
                              setState(() => selectedDisease = disease),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          reDirectUserImage(context);
                        },
                        icon: const Icon(
                          Icons.upload_file,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Previously uploaded image",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          uploadImage(context);
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
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (state == AppState.free) {
            _pickImage();
          } else if (state == AppState.picked) {
            _cropImage();
          } else if (state == AppState.cropped) {
            _clearImage();
          }
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Future _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final pickImage = await _picker.pickImage(source: ImageSource.gallery);
      // selectedImage = File(pickImage!.path);
      // selectedImage = pickImage != null ? File(pickImage.path) : null;
      if (pickImage == null) return;
      selectedImage = File(pickImage.path);
      if (selectedImage != null) {
        setState(() {
          state = AppState.picked;
        });
      }
    } catch (error) {
      print("error in pick image: $error");
    }
  }

  Future _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: selectedImage!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      selectedImage = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  Future _clearImage() async {
    selectedImage = null;
    setState(() {
      state = AppState.free;
    });
  }

  _buildButtonIcon() {
    if (state == AppState.free) {
      return const Icon(Icons.add);
    } else if (state == AppState.picked) {
      return const Icon(Icons.crop);
    } else if (state == AppState.cropped) {
      return const Icon(Icons.clear);
    } else {
      return const SizedBox();
    }
  }
}
// Single child s
      
      
      
      
      
      
      
      
      
      
      
      
  

  