// To parse this JSON data, do
//
//     final bus = busFromMap(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

Bus busFromMap(String str) => Bus.fromMap(json.decode(str));

String busToMap(Bus data) => json.encode(data.toMap());

class Bus {
    Bus({
        this.destination,
        this.time,
        this.busName,
    });

    String destination;
    String time;
    String busName;

    factory Bus.fromMap(Map<String, dynamic> json) => Bus(
        destination: json["destination"] == null ? null : json["destination"],
        time: json["time"] == null ? null : json["time"],
        busName: json["busName"] == null ? null : json["busName"],
    );

    Map<String, dynamic> toMap() => {
        "destination": destination == null ? null : destination,
        "time": time == null ? null : time,
        "busName": busName == null ? null : busName,
    };
}
