import 'package:flutter/material.dart';

import '../../title_bar.dart';
import '../services/medapi.dart';

class addmedrecform extends StatefulWidget {
  const addmedrecform({Key? key}) : super(key: key);

  @override
  State<addmedrecform> createState() => _addmedrecformState();
}

class _addmedrecformState extends State<addmedrecform> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 143, 139, 139),
        title: const TitleBar(
          sectionName: "Add New Record",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Add New Medical Records',
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
                    hintText: 'Enter Drug Name',
                    labelText: 'Drug Name',
                    errorText:
                        _validatedrugName ? 'Drug Name Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _conditionNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter condition name',
                    labelText: 'Condition Name',
                    errorText: _validateconditionname
                        ? 'Condition name Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _ratingController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter rating (0-10)',
                    labelText: 'Rating',
                    errorText:
                        _validaterating ? 'Rating Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _dosageController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Dosage',
                    labelText: 'Dosage',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _sideEffectsController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Side Effects',
                    labelText: 'Side Effects',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Price of the medication',
                    labelText: 'Price',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution1Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Precaution 1',
                    labelText: 'Precaution 01',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution2Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Precaution 2',
                    labelText: 'Precaution 02',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution3Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Precaution 3',
                    labelText: 'Precaution 03',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _precaution4Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Precaution 4',
                    labelText: 'Precaution 04',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Description of the condition',
                    labelText: 'Conditions description',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _drugNameController.text.isEmpty
                              ? _validatedrugName = true
                              : _validatedrugName = false;
                          _conditionNameController.text.isEmpty
                              ? _validateconditionname = true
                              : _validateconditionname = false;
                          _ratingController.text.isEmpty
                              ? _validaterating = true
                              : _validaterating = false;
                        });
                        if (_validatedrugName == false &&
                            _validateconditionname == false &&
                            _validaterating == false) {
                          var result = await medapi().add_record(
                              _drugNameController.text,
                              _conditionNameController.text,
                              _ratingController.text,
                              _dosageController.text,
                              _sideEffectsController.text,
                              _priceController.text,
                              _precaution1Controller.text,
                              _precaution2Controller.text,
                              _precaution3Controller.text,
                              _precaution4Controller.text,
                              _descriptionController.text,
                              _reccomendedController.text);
                          Navigator.pop(context, result);
                        }
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromARGB(255, 91, 90, 90),
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text('Save Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      onPressed: () {
                        _drugNameController.text = "";
                        _conditionNameController.text = "";
                        _ratingController.text = "";
                        _dosageController.text = "";
                        _sideEffectsController.text = "";
                        _priceController.text = "";
                        _precaution1Controller.text = "";
                        _precaution2Controller.text = "";
                        _precaution3Controller.text = "";
                        _precaution4Controller.text = "";
                        _descriptionController.text = "";
                        _reccomendedController.text = "";
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text('Clear Details')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
