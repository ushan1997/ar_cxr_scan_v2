// To parse this JSON data, do
//

import 'dart:convert';

List<Med> medFromJson(String str) =>
    List<Med>.from(json.decode(str).map((x) => Med.fromJson(x)));

String medToJson(List<Med> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Med {
  Med(
      {required this.id,
      required this.drugName,
      required this.conditionName,
      required this.rating,
      required this.dosage,
      required this.sideEffects,
      required this.price,
      required this.precaution1,
      required this.precaution2,
      required this.precaution3,
      required this.precaution4,
      required this.description,
      required this.recommended});

  int id;
  String drugName;
  String conditionName;
  String rating;
  String dosage;
  String sideEffects;
  String price;
  String precaution1;
  String precaution2;
  String precaution3;
  String precaution4;
  String description;
  String recommended;

  factory Med.fromJson(Map<String, dynamic> json) => Med(
        id: json["id"],
        drugName: json["drugName"],
        conditionName: json["conditionName"],
        rating: json["rating"],
        dosage: json["dosage"],
        sideEffects: json["sideEffects"],
        price: json["price"],
        precaution1: json["precaution1"],
        precaution2: json["precaution2"],
        precaution3: json["precaution3"],
        precaution4: json["precaution4"],
        description: json["description"],
        recommended: json["recommended"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "drugName": drugName,
        "conditionName": conditionName,
        "rating": rating,
        "dosage": dosage,
        "sideEffects": sideEffects,
        "price": price,
        "precaution1": precaution1,
        "precaution2": precaution2,
        "precaution3": precaution3,
        "precaution4": precaution4,
        "description": description,
        "recommended": recommended,
      };

  @override
  String toString() {
    String resultdrug = drugName;
    return resultdrug;
  }

  // @override
  // String toString() {
  //   String resultcond = conditionName;
  //   return resultcond;
  // }
}
