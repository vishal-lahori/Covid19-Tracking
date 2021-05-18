import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HowItSpreadScreen extends StatelessWidget {
  static const String route = '/how-it-spread-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How It\'s Spread'),
      ),
      body: ListView(
        children: [
          HowItsSpreadCard(
            image: 'assets/how_it_spreads/spread.png',
            title: 'COVID-19 spreads very easily from person to person.',
            content:
                'How easily a virus spreads from person to person can vary. The virus that causes COVID-19 appears to spread more efficiently than influenza but not as efficiently as measles, which is among the most contagious viruses known to affect people.',
          ),
          HowItsSpreadCard(
            image: 'assets/how_it_spreads/pandemic.png',
            title: 'COVID-19 most commonly spreads during close contact.',
            content:
                'People who are physically near (within 6 feet) a person with COVID-19 or have direct contact with that person are at greatest risk of infection.',
          ),
          HowItsSpreadCard(
            image: 'assets/how_it_spreads/bacteria.png',
            title: 'COVID-19 can sometimes be spread by airborne transmission.',
            content:
                'Some infections can be spread by exposure to virus in small droplets and particles that can linger in the air for minutes to hours. These viruses may be able to infect people who are further than 6 feet away from the person who is infected or after that person has left the space.',
          ),
          HowItsSpreadCard(
            image: 'assets/how_it_spreads/virus-transmission.png',
            title:
                'COVID-19 spreads less commonly through contact with contaminated surfaces.',
            content:
                'Respiratory droplets can also land on surfaces and objects. It is possible that a person could get COVID-19 by touching a surface or object that has the virus on it and then touching their own mouth, nose, or eyes.',
          ),
          HowItsSpreadCard(
            image: 'assets/how_it_spreads/carrier.png',
            title: 'COVID-19 rarely spreads between people and animals.',
            content:
                'It appears that the virus that causes COVID-19 can spread from people to animals in some situations. CDC is aware of a small number of pets worldwide, including cats and dogs, reported to be infected with the virus that causes COVID-19, mostly after close contact with people with COVID-19. Learn what you should do if you have pets.',
          ),
        ],
      ),
    );
  }
}
