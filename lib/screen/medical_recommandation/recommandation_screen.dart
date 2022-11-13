import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:ar_cxr_scan/screen/medical_recommandation/Condition.dart';
import 'package:ar_cxr_scan/screen/medical_recommandation/Medicine.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommandationScreen extends StatefulWidget {
  const RecommandationScreen({Key? key}) : super(key: key);

  @override
  State<RecommandationScreen> createState() => _RecommandationScreenState();
}

class _RecommandationScreenState extends State<RecommandationScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  List<Medicine> medicineList = [
    const Medicine(1, 'acanya'),
    const Medicine(2, 'accutane'),
    const Medicine(3, 'acnex'),
    const Medicine(4, 'acticlate'),
    const Medicine(5, 'aczone'),
    const Medicine(6, 'adapalene'),
    const Medicine(7, 'adapalene / benzoyl peroxide'),
    const Medicine(8, 'adoxa'),
    const Medicine(9, 'aldactone'),
    const Medicine(10, 'altabax'),
    const Medicine(11, 'amnesteem'),
    const Medicine(12, 'atralin'),
    const Medicine(13, 'avar'),
    const Medicine(14, 'avita'),
    const Medicine(15, 'azelaic acid'),
    const Medicine(16, 'azelex'),
    const Medicine(17, 'bactrim'),
    const Medicine(18, 'bactrim ds'),
    const Medicine(19, 'benzaclin'),
    const Medicine(20, 'benzamycin'),
    const Medicine(21, 'benzamycin'),
    const Medicine(22, 'benzefoam ultra'),
    const Medicine(23, 'benzoyl peroxide'),
    const Medicine(24, 'benzoyl peroxide / clindamycin'),
    const Medicine(353, 'sofosbuvir'),
    const Medicine(354, 'sofosbuvir / velpatasvir'),
    const Medicine(358, 'sovaldi'),
    const Medicine(376, 'telaprevir'),
    const Medicine(409, 'victrelis'),
    const Medicine(410, 'viekira pak'),
    const Medicine(421, 'zepatier'),
    const Medicine(130, 'diazoxide'),
    const Medicine(185, 'glucose'),
    const Medicine(207, 'insta-glucose'),
    const Medicine(323, 'proglycem'),
    const Medicine(139, 'doxycycline'),
    const Medicine(292, 'ondansetron'),
    const Medicine(424, 'zofran'),
    const Medicine(425, 'zofran odt'),
    const Medicine(153, 'epivir-hbv'),
    const Medicine(219, 'lamivudine'),
    const Medicine(378, 'tenofovir'),
    const Medicine(411, 'viread'),
    const Medicine(194, 'horse chestnut'),
    const Medicine(314, 'polidocanol'),
    const Medicine(243, 'methimazole'),
    const Medicine(311, 'pima'),
    const Medicine(315, 'potassium iodide'),
    const Medicine(358, 'tapazole'),
  ];
  Medicine? medDropdownValue;
  List<Condition> conditionList = [
    const Condition(0, 'acne'),
    const Condition(5, 'hepatitis c'),
    const Condition(7, 'hypoglycemia'),
    const Condition(1, 'gastroenteritis'),
    const Condition(4, 'hepatitis b'),
    const Condition(13, 'varicose veins'),
    const Condition(6, 'hyperthyroidism'),
    const Condition(2634, 'depression')
  ];
  Condition? conDropdownValue;

  Future Recommand() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/recommand'),
        body: jsonEncode([
          {
            "drugName_n": medDropdownValue!.id,
            "condition_n": conDropdownValue!.id,
          }
        ]),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseMessage = data["prediction_text"];
        print(data["prediction_text"]);
        CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: responseMessage,
        );
        return data;
      } else
        print(data);
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error occured")));
    }
  }

  @override
  void initState() {
    medDropdownValue = medicineList[0];
    conDropdownValue = conditionList[0];
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Recommandation'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(left: 40, right: 20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      SizedBox(
                        child: DropdownButton<Medicine>(
                          value: medDropdownValue,
                          onChanged: (newValue) {
                            setState(() {
                              medDropdownValue = newValue;
                            });
                          },
                          items: medicineList.map((Medicine medicine) {
                            return new DropdownMenuItem<Medicine>(
                              value: medicine,
                              child: new Text(
                                medicine.name,
                                style: new TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: DropdownButton<Condition>(
                          value: conDropdownValue,
                          onChanged: (newValue) {
                            setState(() {
                              conDropdownValue = newValue;
                            });
                          },
                          items: conditionList.map((Condition condition) {
                            return new DropdownMenuItem<Condition>(
                              value: condition,
                              child: new Text(
                                condition.name,
                                style: new TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Expanded(
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Colors.red,
                          //       minimumSize: const Size(40, 40),
                          //     ),
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const PartScreen()));
                          //     },
                          //     child: const Text("Cancel"),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  minimumSize: const Size(40, 40),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Recommand();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    //Navigator.pop(context);
                                  }
                                },
                                child: const Text("Check")),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
