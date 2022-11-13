
import 'package:ar_cxr_scan/screen/medical_recommandation/view/viewbyconditionpage.dart';
import 'package:flutter/material.dart';

import '../../title_bar.dart';
import '../models/medlist.dart';

class FilterconditionPage extends StatefulWidget {
  const FilterconditionPage({Key? key}) : super(key: key);

  @override
  State<FilterconditionPage> createState() => _FilterconditionPageState();
}

class _FilterconditionPageState extends State<FilterconditionPage> {
  final controller = TextEditingController();
  List<newmed> meds = allmeds;

  void searchcondition(String query) {
    final suggestions = allmeds.where((newmed) {
      final conditionname = newmed.conditionName.toLowerCase();
      final input = query.toLowerCase();

      return conditionname.contains(input);
    }).toList();

    setState(() => meds = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: "Filter Medical Details By condition",
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Enter condition Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 91, 90, 90))),
              ),
              onChanged: searchcondition,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meds.length,
              itemBuilder: (context, index) {
                final newmed = meds[index];
                return ListTile(
                    title: Text(newmed.conditionName),
                    subtitle: Text(newmed.drugName),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              viewbyconditionpage(mednew: newmed),
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
