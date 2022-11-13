import 'package:ar_cxr_scan/screen/title_bar.dart';
import 'package:ar_cxr_scan/screen/visualize_x_ray_using_ar/ar_screen.dart';
import 'package:ar_cxr_scan/screen/visualize_x_ray_using_ar/link_configure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ARConfigScreen extends StatefulWidget {
    final String link;
  const ARConfigScreen({
    Key? key,
    required this.link,
    }) : super(key: key);
   @override
  State<ARConfigScreen> createState() => _ARConfigScreenState();
}

class _ARConfigScreenState extends State<ARConfigScreen> {
  String passLink = "";
    bool isloading = false;
  @override
  void initState() {
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: 'AR',
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "  Augemnted Reality X-Ray Image",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/testT.jpeg",
              width: 200,
              height: 200,
            ),
            Column(
              children: const [
                SizedBox(
                  width: double.infinity,
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "     To view the augmented reality app you need to download the following image and do the following steps as below Youtube Demonstration video",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () async {
      
              },
              icon: const Icon(
                Icons.video_collection_sharp,
                color: Colors.white,
              ),
              label: const Text(
                "Watch Demostraion Video",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
             const SizedBox(
              height: 30,
            ),
              TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LinkConfigure()));
              },
              icon: const Icon(
                Icons.video_collection_sharp,
                color: Colors.white,
              ),
              label: const Text(
                "Link Configure",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(passLink);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ARScreen(link: passLink)));
        },
        child: const Icon(
          Icons.line_axis,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}

