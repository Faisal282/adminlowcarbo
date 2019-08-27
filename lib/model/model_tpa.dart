// To parse this JSON data, do
//
//     final tpa = tpaFromJson(jsonString);

import 'dart:convert';

Tpa tpaFromJson(String str) => Tpa.fromJson(json.decode(str));

String tpaToJson(Tpa data) => json.encode(data.toJson());

class Tpa {
    bool status;
    List<Map<String, String>> data;

    Tpa({
        this.status,
        this.data,
    });

    factory Tpa.fromJson(Map<String, dynamic> json) => new Tpa(
        status: json["status"],
        data: new List<Map<String, String>>.from(json["data"].map((x) => new Map.from(x).map((k, v) => new MapEntry<String, String>(k, v == null ? null : v)))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": new List<dynamic>.from(data.map((x) => new Map.from(x).map((k, v) => new MapEntry<String, dynamic>(k, v == null ? null : v)))),
    };
}
