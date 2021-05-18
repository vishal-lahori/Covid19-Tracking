import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../data/providers/countries_reports.dart';

import '../constants/constants.dart';

import '../widgets/detail_card.dart';

class CountryCard extends StatefulWidget {
  final int index;

  CountryCard({@required this.index});

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    if (_animation.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountriesReports>(
      builder: (context, reports, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ScaleTransition(
                scale: _animation,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: kDecoration,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Future.delayed(Duration(milliseconds: 200), () {
                        return buildCaseDetailsBottomSheet(
                          context: context,
                          reports: reports,
                        );
                      });
                    },
                    leading: FadeInImage(
                      placeholder: AssetImage(
                        'assets/country_flags/default.png',
                      ),
                      fit: BoxFit.cover,
                      image: AssetImage(
                          reports.countriesReports[widget.index].image),
                      imageErrorBuilder: (context, object, stacktrace) {
                        return Image.asset('assets/country_flags/default.png');
                      },
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        reports.countriesReports[widget.index].country,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Total : ${NumberFormat.compact().format(double.parse(reports.countriesReports[widget.index].totalCases))}',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              'Active : ${NumberFormat.compact().format(double.parse(reports.countriesReports[widget.index].activeCases))}',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future buildCaseDetailsBottomSheet({
    BuildContext context,
    @required CountriesReports reports,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: kBottomSheetShape,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        reports.countriesReports[widget.index].country,
                        style: TextStyle(fontSize: 22, letterSpacing: 1),
                      ),
                    ),
                    DetailCard(
                      label: 'Total',
                      data: NumberFormat.compact().format(
                        double.parse(
                          reports.countriesReports[widget.index].totalCases,
                        ),
                      ),
                      color: Colors.lime,
                    ),
                    DetailCard(
                      label: 'New',
                      data: NumberFormat.compact().format(
                        double.parse(
                          reports.countriesReports[widget.index].newCases,
                        ),
                      ),
                      color: Colors.pink[400],
                    ),
                    DetailCard(
                      label: 'Active',
                      data: NumberFormat.compact().format(
                        double.parse(
                          reports.countriesReports[widget.index].activeCases,
                        ),
                      ),
                      color: Colors.lightBlue,
                    ),
                    DetailCard(
                      label: 'Critical',
                      data: NumberFormat.compact().format(
                        double.parse(
                          reports.countriesReports[widget.index].criticalCases,
                        ),
                      ),
                      color: Colors.amber,
                    ),
                    DetailCard(
                      label: 'Recovered',
                      data: NumberFormat.compact().format(
                        double.parse(
                          reports.countriesReports[widget.index].recovered,
                        ),
                      ),
                      color: Colors.lightGreen,
                    ),
                    DetailCard(
                      label: 'Deaths',
                      data: NumberFormat.compact().format(
                        double.parse(
                          reports.countriesReports[widget.index].totalDeaths,
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
