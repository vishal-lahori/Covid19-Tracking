import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:image_picker/image_picker.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../data/models/vaccine_passport.dart';
import '../../data/providers/vaccine_passport_registration.dart';

import '../constants/constants.dart';

import '../widgets/widgets.dart';

class CreateProfileScreen extends StatefulWidget {
  static const String route = '/create-profile-screen';

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _datePickerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File _image;

  final userData = {};

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected!');
      }
    });
  }

  Future<Null> buildDatePicker(BuildContext context) async {
    final DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
      builder: (context, child) => kDatePickerDecoration(child),
    );
    if (selectedDate == null) return;
    setState(() {
      _datePickerController.text = DateFormat.yMd().format(selectedDate);
      userData['vaccinationDate'] = _datePickerController.text;
    });
  }

  Future buildImagePickerBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: kBottomSheetShape,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 180,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      icon: Icons.camera_alt_rounded,
                      text: 'Camera',
                      onTap: () => getImage(ImageSource.camera),
                    ),
                    ActionButton(
                      icon: Icons.collections_rounded,
                      text: 'Gallery',
                      onTap: () => getImage(ImageSource.gallery),
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

  @override
  Widget build(BuildContext context) {
    final _token =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Consumer<VaccinePassportRegistration>(
      builder: (context, data, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                data.passport.isNotEmpty ? 'Update Profile' : 'Create Profile',
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Container(
                    //   decoration: kProfileDecoration,
                    //   alignment: Alignment.center,
                    //   margin: EdgeInsets.all(10),
                    //   height: 150,
                    //   width: 150,
                    //   child: _image == null
                    //       ? GestureDetector(
                    //           onTap: () => buildImagePickerBottomSheet(context),
                    //           child: Icon(
                    //             Icons.camera_alt_rounded,
                    //             size: 50,
                    //           ),
                    //         )
                    //       : CircleAvatar(
                    //           backgroundImage: FileImage(_image),
                    //           radius: double.infinity,
                    //         ),
                    // ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        initialValue: data.passport.isNotEmpty
                            ? data.passport[0].name
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Name',
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Required';
                          }

                          return null;
                        },
                        onSaved: (input) {
                          userData['name'] = input;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        initialValue: data.passport.isNotEmpty
                            ? data.passport[0].email
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          labelText: 'Email',
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Required';
                          }

                          if (!(input.contains('@') && input.contains('.'))) {
                            return 'Invalid email.';
                          }
                          return null;
                        },
                        onSaved: (input) {
                          userData['email'] = input;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: data.passport.isNotEmpty
                            ? data.passport[0].phone
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone',
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Required';
                          }

                          if (num.parse(input).isNaN) {
                            return 'Invalid phone number.';
                          }
                          return null;
                        },
                        onSaved: (input) {
                          userData['phone'] = input;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        initialValue: data.passport.isNotEmpty
                            ? data.passport[0].gender
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.venusMars),
                          labelText: 'Gender',
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Required';
                          }

                          // if (input.toLowerCase() != 'male' ||
                          //     input.toLowerCase() != 'female') {
                          //   return 'Invalid gender.';
                          // }
                          return null;
                        },
                        onSaved: (input) {
                          userData['gender'] = input;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        initialValue: data.passport.isNotEmpty
                            ? data.passport[0].country
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.globeAfrica),
                          labelText: 'Country',
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        onSaved: (input) {
                          userData['country'] = input;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        initialValue: data.passport.isNotEmpty
                            ? data.passport[0].vaccinationDocumentNumber
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.description_rounded),
                          labelText: 'Vaccination Document Number',
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        onSaved: (input) {
                          userData['vaccinationDocumentNumber'] = input;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        controller: _datePickerController,
                        // initialValue: data.passport.isNotEmpty
                        //     ? data.passport[0].date
                        //     : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.date_range_rounded, size: 28),
                          labelText: 'Vaccination Date',
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        onTap: () => buildDatePicker(context),
                      ),
                    ),
                    SizedBox(height: 14),
                    CustomButton(
                      text: data.passport.isEmpty
                          ? 'CREATE PROFILE'
                          : 'UPDATE PROFILE',
                      icon: data.passport == null
                          ? Icons.create
                          : Icons.update_rounded,
                      isLoading: data.isLoading,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          final VaccinePassport _passport = VaccinePassport(
                            name: userData['name'],
                            email: userData['email'],
                            phone: userData['phone'],
                            gender: userData['gender'],
                            country: userData['country'],
                            vaccinationDocumentNumber:
                                userData['vaccinationDocumentNumber'],
                            date: userData['vaccinationDate'],
                            profileImage: userData['profileImage'],
                          );

                          data.passport.isEmpty
                              ? data
                                  .createVaccinePassport(
                                    passport: _passport,
                                    token: _token['token'],
                                    userId: _token['userId'],
                                  )
                                  .then((value) => Navigator.pop(context))
                              : data
                                  .updateVaccinePassport(
                                    passport: _passport,
                                    token: _token['token'],
                                    userId: _token['userId'],
                                  )
                                  .then((value) => Navigator.pop(context));
                        }
                      },
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
