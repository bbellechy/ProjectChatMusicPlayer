import 'dart:typed_data';
import 'dart:io';
import 'package:chatmusic/models/profile.dart';
import 'package:chatmusic/pages/chatOnline.dart';
import 'package:chatmusic/pages/login.dart';
import 'package:chatmusic/pages/popupSongPage.dart';
import 'package:chatmusic/pages/profile.dart';
import 'package:chatmusic/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //chech state reset submit
  final formkey = GlobalKey<FormState>();
  late Profile profile;
  void initState() {
    super.initState();
    profile = Profile(email: '', password: '', image: '');
  }

  Uint8List? _image;
  // File? selectedImage;
  String _password = '';
  String _confirmPassword = '';

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Error"),
                ),
                body: Center(child: Text("${snapshot.error}")));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                flexibleSpace: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'atma',
                      fontSize: 33,
                      color: Color(0xFFFF6B00),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  // width:
                  //     MediaQuery.of(context).size.width * 0.8, // 80% ของความกว้างของจอ
                  child: Center(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20),
                          CircleAvatar(
                            // backgroundImage: AssetImage(""),
                            radius: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 20.0, 10.0),
                            child: Form(
                              key: formkey,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // username
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Username',
                                        style: TextStyle(
                                            fontFamily: 'Kreon',
                                            fontSize: 18,
                                            color: Color(0xFFFF6B00)),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 270,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          validator: RequiredValidator(
                                              errorText: "Please assign Email"),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (String? email) {
                                            if (email != null) {
                                              setState(() {
                                                profile.email = email;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      //Password
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                            fontFamily: 'Kreon',
                                            fontSize: 18,
                                            color: Color(0xFFFF6B00)),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 270,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          validator: RequiredValidator(
                                              errorText:
                                                  "Please assign Password"),
                                          obscureText: true,
                                          onSaved: (String? password) {
                                            if (password != null) {
                                              setState(() {
                                                profile.password = password;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // button
                                  SizedBox(height: 25),
                                  Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: SizedBox(
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                formkey.currentState!.save();
                                                try {
                                                  await FirebaseAuth.instance
                                                      .signInWithEmailAndPassword(
                                                          email: profile.email,
                                                          password:
                                                              profile.password)
                                                      .then((value) {
                                                    formkey.currentState!
                                                        .reset();
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           ChatOnlinePage()),
                                                    // );
                                                    Navigator.pushNamedAndRemoveUntil(context, '/profile',
                                                    ModalRoute.withName('/profile'));
                                                  });
                                                } on FirebaseAuthException catch (e) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          title: Text("Error"),
                                                          content: Text(e
                                                                  .message ??
                                                              "An error occurred"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text('OK'),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 18,
                                                color: Color(0xFFFF6B00),
                                              ),
                                            )),
                                      )),
                                  // button
                                  SizedBox(height: 15),
                                  Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: SizedBox(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/register',
                                                  ModalRoute.withName(
                                                      '/register'));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 15,
                                                color: Color(0xFFFF6B00),
                                              ),
                                            )),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
