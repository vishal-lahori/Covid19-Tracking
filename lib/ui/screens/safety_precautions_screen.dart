import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SafetyPrecautionsScreen extends StatelessWidget {
  static const String route = '/safety-precautions-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety Precautions'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SafetyPrecaution(
            image: 'assets/safety_precautions/mask_protection.png',
            title: 'Wear a Face Mask',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/social_distancing.png',
            title: 'Maintain Social Distance',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/no_group.png',
            title: 'Avoid Crowds',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/washing_hands.png',
            title: 'Wash Your Hands Often',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/cough.png',
            title: 'Cover Coughs and Sneezes',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/temperature.png',
            title: 'Monitor Your Health Daily',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/no_flight_travel.png',
            title: 'Avoid Air Travelling',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/first_aid_kit.png',
            title: 'Get Vaccinated',
          ),
          SafetyPrecaution(
            image: 'assets/safety_precautions/news.png',
            title: 'Stay Informed',
          ),
        ],
      ),
    );
  }
}
