import 'package:flutter/foundation.dart';

class VaccinePassport {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String country;
  final String vaccinationDocumentNumber;
  final String date;
  final String profileImage;

  VaccinePassport({
    this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.gender,
    @required this.country,
    @required this.vaccinationDocumentNumber,
    @required this.date,
    @required this.profileImage,
  });
}
