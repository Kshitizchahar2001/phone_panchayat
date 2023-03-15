// ignore_for_file: file_names, prefer_const_constructors, avoid_print, prefer_const_declarations, prefer_conditional_assignment, curly_braces_in_flow_control_structures

import 'dart:core';
import 'dart:ui';

void main() {
  String a = getTimeDifference(
      recent: DateTime.now(),
      old: DateTime(2021, 5, 12, 15, 24, 52),
      locale: Locale('hi').toString());
  print(a.toString());
}

// enum Unit { Second, Minute, Hour, Day }

final String justNow = "Just now";
final String ago = "ago";
final String second = "second";
final String minute = "minute";
final String hour = "hour";
final String day = "day";

final Map<String, Map<bool, String>> translations = {
  justNow: {
    false: justNow,
    true: "अभी",
  },
  ago: {
    false: ago,
    true: "पूर्व",
  },
  second: {
    false: second,
    true: "सेकंड",
  },
  minute: {
    false: minute,
    true: "मिनट",
  },
  hour: {
    false: hour,
    true: "घंटे",
  },
  day: {
    false: day,
    true: "दिन",
  },
};

String getTimeDifference({DateTime recent, DateTime old, String locale}) {
  bool isHindi = false;
  if (locale == "hi") isHindi = true;

  if (recent == null) recent = DateTime.now();
  int days, hours, minutes, seconds;
  Duration difference = recent.difference(old);
  days = difference.inDays;
  hours = difference.inHours;
  minutes = difference.inMinutes;
  seconds = difference.inSeconds;
  int magnitude = 0; //number of days,hours,minutes , seconds;
  String unit = second;
  if (days > 3)
    return "${old.day}-${old.month}-${old.year}";
  else if (days >= 1) {
    magnitude = days;
    unit = day;
  }
  // "$days days ago";
  else if (hours >= 1) {
    magnitude = hours;
    unit = hour;
  }
  // return "$hours hours ago";
  else if (minutes >= 1) {
    magnitude = minutes;
    unit = minute;
  }
  // return "$minutes minutes ago";
  else if (seconds >= 1) {
    magnitude = seconds;
    unit = second;
  }
  // return "$seconds seconds ago";
  else {
    return translations[justNow][isHindi];
  }

  String plural = "s";
  if (magnitude == 1 || isHindi) plural = "";

  String timeDifference =
      "$magnitude ${translations[unit][isHindi]}$plural ${translations[ago][isHindi]}";
  return timeDifference;
}
