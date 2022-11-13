import 'dart:convert';
import 'dart:io';
import 'package:ar_cxr_scan/screen/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';

class SymptomsInputScreen extends StatefulWidget {
  const SymptomsInputScreen({Key? key}) : super(key: key);

  @override
  State<SymptomsInputScreen> createState() => _SymptomsInputScreenState();
}

class _SymptomsInputScreenState extends State<SymptomsInputScreen> {
  bool isLoading = false;
  int radioValue = 1;
  final _formKey = GlobalKey<FormState>();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final airPollutionController = TextEditingController();
  final alcoholUseController = TextEditingController();
  final dustAllergyController = TextEditingController();
  final occuPationalHazardsController = TextEditingController();
  final geneticRiskController = TextEditingController();
  final chronicLungDiseaseController = TextEditingController();
  final balancedDietController = TextEditingController();
  final obesityController = TextEditingController();
  final smokingController = TextEditingController();
  final passiveSmokerController = TextEditingController();
  final chestPainController = TextEditingController();
  final coughingOfBloodController = TextEditingController();
  final fatigueController = TextEditingController();
  final weightLossController = TextEditingController();
  final shortnessOfBreathController = TextEditingController();
  final wheezingController = TextEditingController();
  final swalHealthyingDifficultyController = TextEditingController();
  final clubbingOfFingerNailsController = TextEditingController();
  final frequentColdController = TextEditingController();
  final dryCoughController = TextEditingController();
  final snoringController = TextEditingController();

  Future predictDieases() async {
    try {
      setState(() {
        isLoading = true;
      });
      final String jsonConfig =
          await rootBundle.loadString('assets/host_config.json');
      final jsonHostData = await json.decode(jsonConfig);
      final response = await http.post(
        Uri.parse('http://10.0.2.2:4000/disease/predict'),
        body: jsonEncode([
          {
            "Age": ageController.text,
            "Gender": radioValue,
            "Air Pollution": airPollutionController.text,
            "Alcohol use": alcoholUseController.text,
            "Dust Allergy": dustAllergyController.text,
            "OccuPational Hazards": occuPationalHazardsController.text,
            "Genetic Risk": geneticRiskController.text,
            "chronic Lung Disease": chronicLungDiseaseController.text,
            "Balanced Diet": balancedDietController.text,
            "Obesity": obesityController.text,
            "Smoking": smokingController.text,
            "Passive Smoker": passiveSmokerController.text,
            "Chest Pain": chestPainController.text,
            "Coughing of Blood": coughingOfBloodController.text,
            "Fatigue": fatigueController.text,
            "Weight Loss": weightLossController.text,
            "Shortness of Breath": shortnessOfBreathController.text,
            "Wheezing": wheezingController.text,
            "SwalHealthying Difficulty":
                swalHealthyingDifficultyController.text,
            "Clubbing of Finger Nails": clubbingOfFingerNailsController.text,
            "Frequent Cold": frequentColdController.text,
            "Dry Cough": dryCoughController.text,
            "Snoring": snoringController.text
          }
        ]),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseMessage = data["prediction_text"];
        CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: responseMessage,
        );
        return data;
      } else {
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error occured")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    //Important rate for Symptoms between 0-9
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: 'Predicting Diseases',
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Text('Important rate for Symptoms between 0-9',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Roboto',
                            color: Color(0xFFF44336),
                          )),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        controller: ageController,
                        onChanged: (String value) {},
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Age",
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Age cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          const Text("Gender :"),
                          Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value as int;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text("Male"),
                          Radio(
                            value: 2,
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value as int;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Text("Female"),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: airPollutionController,
                        onChanged: (String value) {},
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Air Pollution",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Air Pollution cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: alcoholUseController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Alcohol use",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Alcohol use cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: dustAllergyController,
                        onChanged: (String value) {},
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Dust Allergy",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Dust Allergy cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: occuPationalHazardsController,
                        onChanged: (String value) {},
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "OccuPational Hazards",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "OccuPational Hazards cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: geneticRiskController,
                        onChanged: (String value) {},
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Genetic Risk",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Genetic Risk cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: chronicLungDiseaseController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Chronic Lung Disease",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Chronic Lung Disease cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: balancedDietController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Balanced Diet",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Balanced Diet cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: obesityController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Obesity",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Obesity cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: smokingController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Smoking",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Smoking cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: passiveSmokerController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Passive Smoking",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Passive Smoking cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: chestPainController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Chest Pain",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Chest Pain cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: coughingOfBloodController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Coughing of Blood",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Coughing of Blood cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: fatigueController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Fatigue",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Fatigue cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: weightLossController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Weight Loss",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Weight Loss cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: shortnessOfBreathController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Shortness of Breath",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Shortness of Breath cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: wheezingController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Wheezing",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Wheezing cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: swalHealthyingDifficultyController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "SwalHealthying Difficulty",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "SwalHealthying Difficulty cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: clubbingOfFingerNailsController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Clubbing of Finger Nails",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Clubbing of Finger Nails cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: frequentColdController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Frequent Cold",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Frequent Cold cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: dryCoughController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Dry Cough",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Dry Cough cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: snoringController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                            hintText: "Snoring",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Snoring cannot be empty";
                          }
                          if (int.parse(value) > 9) {
                            return "Number must be not greater than 9";
                          }
                          if (int.parse(value) < 0) {
                            return "Number must be not less than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    predictDieases();
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: const Text("Predict Dieases")),
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
