// To parse this JSON data, do
//
//     final train = trainFromMap(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

Train trainFromMap(String str) => Train.fromMap(json.decode(str));

String trainToMap(Train data) => json.encode(data.toMap());

class Train {
    Train({
        this.destination,
        this.time,
        this.trainName,
    });

    String destination;
    String time;
    String trainName;

    factory Train.fromMap(Map<String, dynamic> json) => Train(
        destination: json["destination"] == null ? null : json["destination"],
        time: json["time"] == null ? null : json["time"],
        trainName: json["trainName"] == null ? null : json["trainName"],
    );

    Map<String, dynamic> toMap() => {
        "destination": destination == null ? null : destination,
        "time": time == null ? null : time,
        "trainName": trainName == null ? null : trainName,
    };
}
