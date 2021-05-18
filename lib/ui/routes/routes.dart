import 'package:covid19_tracking/data/providers/vaccine_passport_registration.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

Map<String, WidgetBuilder> routes({VaccinePassportRegistration data}) {
  return {
    HomeScreen.route: (context) => HomeScreen(),
    HowItSpreadScreen.route: (context) => HowItSpreadScreen(),
    SafetyPrecautionsScreen.route: (context) => SafetyPrecautionsScreen(),
    VaccinePassportAuthScreen.route: (context) => VaccinePassportAuthScreen(),
    VaccinePassportScreen.route: (context) =>
        VaccinePassportScreen(vpRegistration: data),
    AboutScreen.route: (context) => AboutScreen(),
    CreateProfileScreen.route: (context) => CreateProfileScreen(),
  };
}
