import 'package:covid19_tracking/ui/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/providers.dart';

import '../widgets/widgets.dart';

import '../screens/screens.dart';

class VaccinePassportScreen extends StatefulWidget {
  static const String route = '/vaccine-passport';
  final VaccinePassportRegistration vpRegistration;

  VaccinePassportScreen({this.vpRegistration});

  @override
  _VaccinePassportScreenState createState() => _VaccinePassportScreenState();
}

class _VaccinePassportScreenState extends State<VaccinePassportScreen> {
  @override
  Widget build(BuildContext context) {
    final _token =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccine Passport'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded),
            splashRadius: 20,
            onPressed: () {
              setState(() {
                widget.vpRegistration.getVaccinePassport(
                  token: _token['token'],
                  userId: _token['userId'],
                );
              });
            },
          ),
        ],
      ),
      body: Consumer<VaccinePassportRegistration>(
        builder: (context, data, _) {
          return data.passport.isEmpty
              ? Center(
                  child: CustomButton(
                    icon: Icons.create,
                    text: 'CREATE PASSPORT',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CreateProfileScreen.route,
                        arguments: _token,
                      );
                    },
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: kProfileDecoration,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        height: 150,
                        width: 150,
                        child: Container(
                          child: Image.asset(
                            data.passport[0].gender.toLowerCase() == 'male'
                                ? 'assets/vaccine-passport/man.png'
                                : 'assets/vaccine-passport/woman.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          data.passport[0].name,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              data.passport[0].vaccinationDocumentNumber
                                      .isNotEmpty
                                  ? Icons.check_circle
                                  : Icons.cancel_outlined,
                              size: 30,
                              color: data.passport[0].vaccinationDocumentNumber
                                      .isNotEmpty
                                  ? Colors.teal
                                  : Colors.deepOrange,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Vaccinated',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/icons/qr-code.png',
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                      CustomButton(
                        text: 'UPDATE DETAILS',
                        icon: Icons.update_rounded,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CreateProfileScreen.route,
                            arguments: _token,
                          );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.vpRegistration.dispose();
    super.dispose();
  }
}
