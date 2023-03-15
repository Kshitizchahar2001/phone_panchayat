// To parse this JSON data, do
//
//     final job = jobFromMap(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

Job jobFromMap(String str) => Job.fromMap(json.decode(str));

String jobToMap(Job data) => json.encode(data.toMap());

class Job {
    Job({
        this.age,
        this.date,
        this.designation,
        this.organization,
        this.qualification,
    });

    int age;
    String date;
    String designation;
    String organization;
    String qualification;

    factory Job.fromMap(Map<String, dynamic> json) => Job(
        age: json["age"] == null ? null : json["age"],
        date: json["date"] == null ? null : json["date"],
        designation: json["designation"] == null ? null : json["designation"],
        organization: json["organization"] == null ? null : json["organization"],
        qualification: json["qualification"] == null ? null : json["qualification"],
    );

    Map<String, dynamic> toMap() => {
        "age": age == null ? null : age,
        "date": date == null ? null : date,
        "designation": designation == null ? null : designation,
        "organization": organization == null ? null : organization,
        "qualification": qualification == null ? null : qualification,
    };
}
