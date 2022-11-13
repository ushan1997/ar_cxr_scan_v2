import 'package:ar_cxr_scan/screen/cxr_disease_identification/cxr_image_classify.dart';
import 'package:ar_cxr_scan/screen/disease_area_identify/dieseas_area_screen.dart';
import 'package:ar_cxr_scan/screen/medical_recommandation/view/mainpage.dart';
import 'package:ar_cxr_scan/screen/visualize_x_ray_using_ar/ar_config_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'home.dart';
import 'medical_recommandation/view/reccomendation.dart';
import 'predicting probability diseases/symptoms_input_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search_off),
            title: Text('Identification of Diseases'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CXRImageClassify(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_device_info),
            title: const Text('Predicting probability diseases'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SymptomsInputScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.recommend),
            title: const Text('Medicine Recommendation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const mainpage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.area_chart_sharp),
            title: const Text('Disease Area Detect'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const mainpage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.visibility_outlined),
            title: const Text('Visualize Lung Anotomy Using AR'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const mainpage(),
                ),
              );
            },
          ),
        ],
      );
}
