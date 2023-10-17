import 'package:final_project/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../Authentication/firebase_Auth/firebase_services.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  bool hidden = true;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController NameCont = TextEditingController();
  TextEditingController PassCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController conf_passCont = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    NameCont.dispose();
    PassCont.dispose();
    emailCont.dispose();
    conf_passCont.dispose();
    super.dispose();
  }
@override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
    print("completed");
    setState(() {});
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text(
            "City Shop",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    "assets/logo.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Sign UP",
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 30,
                        fontFamily: "Ubuntu"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name can not be null';
                      }
                    },
                    controller: NameCont,
                    style: TextStyle(color: Colors.purple),
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_2,
                          color: Colors.purple,
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.purple),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invaild Email';
                      }
                    },
                    controller: emailCont,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.purple),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.purple,
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.purple),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.length < 8 ||
                          value.length >= 13) {
                        return 'Password must be between 8 and 13 character';
                      }
                    },
                    controller: PassCont,
                    obscureText: hidden,
                    style: const TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.purple,
                        ),
                        labelText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              nothidden();
                            },
                            icon: Icon(
                              hidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.purple,
                            )),
                        labelStyle: const TextStyle(color: Colors.purple),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.length < 8 ||
                          value.length >= 13) {
                        return 'Password must be between 8 and 13 character';
                      }
                      if (conf_passCont.text != PassCont.text) {
                        return 'Password not matched';
                      }
                    },
                    controller: conf_passCont,
                    obscureText: hidden,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.purple,
                        ),
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              nothidden();
                            },
                            icon: Icon(
                              hidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.purple,
                            )),
                        labelStyle: const TextStyle(color: Colors.purple),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const login()),
                        );
                      },
                      child: Text("I'm already have an account"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 250,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          SnackBar snack = const SnackBar(
                            content:
                                Center(child: Text("You have an account now")),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        SignUp();
                        }
                        
                      },
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  nothidden() {
    hidden = !hidden;
    setState(() {});
  }

  void SignUp() async {
    String username = NameCont.text;
    String email = emailCont.text;
    String password = PassCont.text;
    User? user = await _auth.signupWithEmailAndPassword(email, password);
    if (user != null) {
      print("Created");
        Navigator.push(context,MaterialPageRoute(
        builder: (context) => const login()),);
    }
  }
}
