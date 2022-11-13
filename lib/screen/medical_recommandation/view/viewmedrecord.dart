import 'package:flutter/material.dart';

import '../../title_bar.dart';
import '../models/med.dart';
import 'mainpage.dart';

class viewmedrecord extends StatefulWidget {
  final Med meds;
  const viewmedrecord(this.meds, {Key? key}) : super(key: key);

  @override
  State<viewmedrecord> createState() => _viewmedrecordState();
}

class _viewmedrecordState extends State<viewmedrecord> {
  var _drugNameController = TextEditingController();
  var _conditionNameController = TextEditingController();
  var _ratingController = TextEditingController();
  var _dosageController = TextEditingController();
  var _sideEffectsController = TextEditingController();
  var _priceController = TextEditingController();
  var _precaution1Controller = TextEditingController();
  var _precaution2Controller = TextEditingController();
  var _precaution3Controller = TextEditingController();
  var _precaution4Controller = TextEditingController();
  var _descriptionController = TextEditingController();
  var _reccomendedController = TextEditingController();

  bool _validatedrugName = false;
  bool _validateconditionname = false;
  bool _validaterating = false;

  @override
  void initState() {
    _drugNameController.text = widget.meds.drugName;
    _conditionNameController.text = widget.meds.conditionName;
    _ratingController.text = widget.meds.rating;
    _dosageController.text = widget.meds.dosage;
    _sideEffectsController.text = widget.meds.sideEffects;
    _priceController.text = widget.meds.price;
    _precaution1Controller.text = widget.meds.precaution1;
    _precaution1Controller.text = widget.meds.precaution2;
    _precaution1Controller.text = widget.meds.precaution3;
    _precaution1Controller.text = widget.meds.precaution4;
    _descriptionController.text = widget.meds.description;
    _reccomendedController.text = widget.meds.recommended;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: "View Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'View Medical Details',
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 91, 90, 90),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _drugNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Drug Name',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _conditionNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Condition Name',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _ratingController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Rating',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _dosageController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Dosage',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _sideEffectsController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Side Effects',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Price',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution1Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Precaution 01',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution2Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Precaution 02',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution3Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Precaution 03',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution4Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Precaution 04',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Conditions description',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _reccomendedController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Reccomendation Status',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.all(25),
                      child: TextButton(
                        child: Text(
                          'Back to search results',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const mainpage()));
                        },
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
