import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
    required this.sectionName,
  }) : super(key: key);

  final String sectionName;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, //down axisi | allighnment
      mainAxisSize: MainAxisSize.min, //main axis => allighnment
      children: [
        Image.asset(
          'assets/cxr.jpg',
          height: 25,
        ),
        const SizedBox(width: 8),
        const Text(
          'CXR Scan',
          style: TextStyle(
            color: Color.fromARGB(255, 121, 183, 255),
            fontSize: 16,
          ),
        ),
        Text(
          // ignore: unnecessary_string_interpolations
          ' $sectionName',
          style: const TextStyle(color: Colors.orange, fontSize: 18),
        ),
      ],
    );
  }
}
