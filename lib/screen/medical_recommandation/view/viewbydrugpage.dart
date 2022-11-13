import 'package:flutter/material.dart';

import '../../title_bar.dart';
import '../models/medlist.dart';
import 'filterdrug.dart';

class viewbydrugpage extends StatelessWidget {
  final newmed mednew;

  const viewbydrugpage({
    Key? key,
    required this.mednew,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 143, 139, 139),
          title: const TitleBar(
            sectionName: "Search by Drug Name",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Condition name :' + mednew.conditionName,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Drug name :' + mednew.drugName,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Rating given :' + mednew.rating,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Dosage :' + mednew.dosage,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Price :' + mednew.price,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Side Effects :' + mednew.sideEffects,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText:
                          'Reccommendation status :' + mednew.recommended,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'precaution 1 :' + mednew.precaution1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'precaution 2 :' + mednew.precaution2,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'precaution 3 :' + mednew.precaution3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'precaution 4 :' + mednew.precaution4,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(25),
                        child: TextButton(
                          child: Text(
                            'Back ',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FilterdrugPage()));
                          },
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
