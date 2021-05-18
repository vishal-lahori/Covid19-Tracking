import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/providers.dart';

import '../widgets/widgets.dart';

import 'screens.dart';

enum Status { sign_in, sign_up }

class VaccinePassportAuthScreen extends StatefulWidget {
  static const String route = '/vaccine-passport-screen';

  @override
  _VaccinePassportAuthScreenState createState() =>
      _VaccinePassportAuthScreenState();
}

class _VaccinePassportAuthScreenState extends State<VaccinePassportAuthScreen> {
  final _key = GlobalKey<FormState>();
  final _authData = {'email': '', 'password': ''};

  var _status = Status.sign_in;
  var _obscureText = true;
  var _animation = 'Close barrier';

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(
      builder: (context, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Vaccine Passport'),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RiveAnimation(animation: _animation),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      onSaved: (input) => _authData['email'] = input,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      onSaved: (input) => _authData['password'] = input,
                    ),
                  ),
                  _status == Status.sign_up
                      ? AnimatedContainer(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          curve: Curves.easeIn,
                          duration: Duration(milliseconds: 3000),
                          child: TextFormField(
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                              ),
                            ),
                            onSaved: (input) {},
                          ),
                        )
                      : Container(),
                  SizedBox(height: 30),
                  CustomButton(
                    icon: _status == Status.sign_in
                        ? Icons.vpn_key
                        : Icons.person_add,
                    text: _status == Status.sign_in ? 'SIGN IN' : 'SIGN UP',
                    onTap: () {
                      _key.currentState.save();
                      if (_status == Status.sign_in) {
                        data
                            .authenticate(
                          email: _authData['email'],
                          password: _authData['password'],
                          action: 1,
                        )
                            .then((_) {
                          return Navigator.pushReplacementNamed(
                            context,
                            VaccinePassportScreen.route,
                            arguments: {
                              'token': data.token,
                              'userId': data.userId
                            },
                          );
                        });
                      }
                      if (_status == Status.sign_up) {
                        data
                            .authenticate(
                          email: _authData['email'],
                          password: _authData['password'],
                          action: 2,
                        )
                            .then((_) {
                          return Navigator.pushReplacementNamed(
                            context,
                            VaccinePassportScreen.route,
                            arguments: {
                              'token': data.token,
                              'userId': data.userId
                            },
                          );
                        });
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: TextButton.icon(
                      icon: Icon(
                        _status == Status.sign_in
                            ? Icons.person_add
                            : Icons.person,
                      ),
                      label: Text(
                        _status == Status.sign_in ? 'NEW USER?' : 'SIGN IN',
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_status == Status.sign_in) {
                            _status = Status.sign_up;
                          } else {
                            _status = Status.sign_in;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
