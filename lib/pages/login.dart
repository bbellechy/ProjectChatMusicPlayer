import 'package:chatmusic/models/profile.dart';
import 'package:chatmusic/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
    profile = Profile(email: '', password: '');
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Container(
          // width:
          //     MediaQuery.of(context).size.width * 0.8, // 80% ของความกว้างของจอ
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                CircleAvatar(
                  // backgroundImage: AssetImage(""),
                  radius: 80,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // username
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: TextFormField(
                                validator: RequiredValidator(
                                    errorText: "Please assign Email"),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (String? email) {
                                  if (email != null) {
                                    setState(() {
                                      profile.email = email;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
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
                              child: TextFormField(
                                validator: RequiredValidator(
                                    errorText: "Please assign Password"),
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
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
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
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      formkey.currentState!.save();
                                      print(
                                          "email = ${profile.email} password = ${profile.password}");
                                      formkey.currentState!.reset();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
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
    );
  }
}
