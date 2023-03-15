// ignore_for_file: file_names

abstract class RadiusData {
  double radius = 30;
  List kilometerRange = [
    5,
    10,
    15, // New added
    20,
    30,
    50,
  ];
  void performQuery();
}
