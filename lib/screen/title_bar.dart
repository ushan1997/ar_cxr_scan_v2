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
        Text(
          // ignore: unnecessary_string_interpolations
          ' $sectionName',
          style: const TextStyle(color: Colors.orange, fontSize: 18),
        ),
      ],
    );
  }
}
