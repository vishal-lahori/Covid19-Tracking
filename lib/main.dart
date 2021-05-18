import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'data/providers/providers.dart';

import 'ui/routes/routes.dart';

import 'ui/theme/theme.dart';

import 'ui/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    final _globalReports = GlobalReports();
    final _countriesReports = CountriesReports();
    final _vaccineReports = VaccineReports();
    final _authentication = Authentication();
    final _vaccinePassportRegistration = VaccinePassportRegistration();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authentication),
        ChangeNotifierProvider.value(value: _globalReports),
        ChangeNotifierProvider.value(value: _countriesReports),
        ChangeNotifierProvider.value(value: _vaccineReports),
        ChangeNotifierProvider.value(value: _vaccinePassportRegistration),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'COVID19 TRACKING',
          theme: theme,
          home: FutureBuilder(
            future: Future.wait([
              _globalReports.getData(),
              _countriesReports.getData(),
              _vaccineReports.getData(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return SplashScreen();
                } else {
                  return HomeScreen();
                }
              } else {
                return HomeScreen();
              }
            },
          ),
          routes: routes(data: _vaccinePassportRegistration),
        );
      },
    );
  }
}
