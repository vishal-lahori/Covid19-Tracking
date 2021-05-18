import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/countries_reports.dart';

import '../widgets/widgets.dart';

class AllCountriesScreen extends StatefulWidget {
  @override
  _AllCountriesScreenState createState() => _AllCountriesScreenState();
}

class _AllCountriesScreenState extends State<AllCountriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CountriesReports>(
      builder: (context, reports, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (var input) =>
                      reports.searchCountry(keyword: input),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
              ),
              Expanded(
                child: !reports.isLoading
                    ? ListView.builder(
                        padding: EdgeInsets.all(10),
                        physics: BouncingScrollPhysics(),
                        itemCount: reports.countriesReports.length,
                        itemBuilder: (context, index) =>
                            CountryCard(index: index),
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }
}
