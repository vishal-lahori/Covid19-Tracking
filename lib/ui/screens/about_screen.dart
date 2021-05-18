import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:square_in_app_payments/in_app_payments.dart';

import '../constants/constants.dart';
import '../widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  static const String route = '/about-screen';

  final _formKey = GlobalKey<FormState>();

  Future<void> pay(BuildContext context) async {
    await InAppPayments.setSquareApplicationId('sq0idp--J0bUY2RykQk2tXEOa9UrQ');
    await InAppPayments.startCardEntryFlow(
      onCardNonceRequestSuccess: (result) {
        try {
          buildResultSnackBar(context, 'Thanks for your donation!');
          InAppPayments.completeCardEntry(onCardEntryComplete: () {});
        } on Exception catch (error) {
          buildResultSnackBar(context, 'Something went wrong!');
          InAppPayments.showCardNonceProcessingError(error.toString());
        }
      },
      onCardEntryCancel: () {
        buildResultSnackBar(context, 'Payment has been cancelled!');
      },
      collectPostalCode: false,
    );
  }

  void buildResultSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Text(message),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.black26,
          shape: kBottomSheetShape,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                validator: (input) {
                                  if (input == null ||
                                      input.isEmpty ||
                                      input == '') {
                                    return 'Please enter valid amount!';
                                  }

                                  if (num.parse(input) < 0 ||
                                      int.parse(input) == 0) {
                                    return 'Amount should not be negative or zero!';
                                  }

                                  if (num.parse(input).isNaN) {
                                    return 'Amount is not valid!';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  prefixIcon: Icon(Icons.attach_money_rounded),
                                ),
                                onChanged: (input) {},
                              ),
                            ),
                          ),
                          CustomButton(
                            text: 'Make Donation',
                            icon: Icons.payment_rounded,
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                FocusScope.of(context).unfocus();
                                pay(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        label: Text('Donate Us'),
        backgroundColor: Colors.yellow[700],
        icon: Icon(Icons.payment_outlined),
      ),
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileCard(
            avatar: 'assets/avatar/avatar-i.png',
            name: 'Ravi Kansagara',
            email: 'ravi.kansagara@outlook.com',
          ),
          ProfileCard(
            avatar: 'assets/avatar/avatar-ii.png',
            name: 'Ruchita Trivedi',
            email: 'ruchi_trivedi@yahoo.com',
          ),
          ProfileCard(
            avatar: 'assets/avatar/avatar-iii.png',
            name: 'Pratik Barvaliya',
            email: 'pratik.barvaliya@gmail.com',
          ),
        ],
      ),
    );
  }
}
