import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import '../title_bar.dart';

class ARScreen extends StatefulWidget {
  final String link;
  const ARScreen({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  String passLink = "";
    @override
  void initState() {
    super.initState();
     (() async {
        if (mounted) {
          setState(() {
            passLink = widget.link;
          });
        }
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: 'AR for X-Ray',
        ),
      ),
      body: Card(
        margin: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            UnityWidget(
              onUnityCreated: onUnityCreated,
            )
          ],
        ),
      ),
    );
  }

  void onUnityCreated(UnityWidgetController controller) async{
    String url="";
      final String jsonConfig =
        await rootBundle.loadString('assets/host_config.json');
    final jsonHostData = await json.decode(jsonConfig);
    if(passLink==""){
      url = jsonHostData["areadt_host"] + "/areadt/getmask";
    }else{
       url = passLink + "/areadt/getmask";
    }
    print("############################### URL --->" +
        url +
        "#####################");
    controller.postMessage('GetURLObject', 'GetMessageFunction', url);
  }
}
