// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class ProfessionalService {
  ProfessionalService(
      {@required this.nameEn,
      @required this.nameHi,
      @required this.id,
      @required this.containsSubServices,
      this.subServices});

  String nameHi;
  String nameEn;
  String id;
  bool containsSubServices;
  List<ProfessionalService> subServices;
}
