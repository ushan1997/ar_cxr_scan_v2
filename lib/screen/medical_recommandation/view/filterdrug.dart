import 'package:flutter/material.dart';

import '../../title_bar.dart';
import '../models/medlist.dart';
import 'viewbydrugpage.dart';

class FilterdrugPage extends StatefulWidget {
  const FilterdrugPage({Key? key}) : super(key: key);

  @override
  State<FilterdrugPage> createState() => _FilterdrugPageState();
}

class _FilterdrugPageState extends State<FilterdrugPage> {
  final controller = TextEditingController();
  List<newmed> meds = allmeds;

  void searchuser(String query) {
    final suggestions = allmeds.where((newmed) {
      final username = newmed.drugName.toLowerCase();
      final input = query.toLowerCase();

      return username.contains(input);
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
          sectionName: "Filter Medical Details By Drug",
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
                hintText: 'Enter Drug Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 91, 90, 90))),
              ),
              onChanged: searchuser,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meds.length,
              itemBuilder: (context, index) {
                final newmed = meds[index];
                return ListTile(
                    title: Text(newmed.drugName),
                    subtitle: Text(newmed.conditionName),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => viewbydrugpage(mednew: newmed),
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
