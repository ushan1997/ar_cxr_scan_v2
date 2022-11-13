
import 'package:ar_cxr_scan/screen/app_drawer.dart';
import 'package:ar_cxr_scan/screen/disease_area_identify/dieseas_area_screen.dart';
import 'package:ar_cxr_scan/screen/medical_recommandation/view/mainpage.dart';
import 'package:ar_cxr_scan/screen/title_bar.dart';
import 'package:ar_cxr_scan/screen/visualize_x_ray_using_ar/ar_config_screen.dart';
import 'package:flutter/material.dart';

import 'cxr_disease_identification/cxr_image_classify.dart';
import 'medical_recommandation/view/reccomendation.dart';
import 'predicting probability diseases/symptoms_input_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late TextEditingController controller;
  String link = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: 'Home',
        ),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
            GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CXRImageClassify(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/Identification_diseases.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(
                        "Identification of diseases",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SymptomsInputScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/predicting.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(
                        "Predicting  diseases",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const mainpage(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/recomond.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(
                        "Medicine Recommendation",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DiseaseAreaScreen(link: link)));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/areadt.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(
                        "Dsease Area Detect",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), //shadow
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ARConfigScreen(link: link)));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/ar.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(
                        "AR for Lung Anatomy",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ],
        )),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final link = await openLinkDialog();
          if (link == null || link.isEmpty) return;
          setState(() {
            this.link = link;
          });
        },
        child: const Icon(
          Icons.rocket_launch,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
  
   Future<String?> openLinkDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Enter AR Link"),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter the link'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                cancelLink();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                submitLink();
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      );

  void submitLink() {
    Navigator.of(context).pop(controller.text);
  }
  void cancelLink() {
    Navigator.of(context).pop();
    controller.clear();
  }
}
