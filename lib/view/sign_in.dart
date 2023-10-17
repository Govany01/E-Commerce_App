import 'package:final_project/view/second_screen.dart';
import 'package:final_project/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Authentication/firebase_Auth/firebase_services.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool hidden = true;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController PassCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    PassCont.dispose();
    emailCont.dispose();
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
                    "Login",
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
                        return 'Invaild Email';
                      }
                    },
                    style: TextStyle(color: Colors.purple),
                    controller: emailCont,
                    keyboardType: TextInputType.emailAddress,
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
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.length < 8 ||
                          value.length >= 13) {
                        return 'Password must be between 8 and 13 character';
                      }
                    },
                    style: TextStyle(color: Colors.purple),
                    controller: PassCont,
                    obscureText: hidden,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const sign_up()),
                        );
                      },
                      child: Text("I'm do not have an account"),
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
                          SignIn();
                        }
                      },
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
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

  void SignIn() async {
    String email = emailCont.text;
    String password = PassCont.text;
    User? user = await _auth.signinWithEmailAndPassword(email, password);
    SharedPreferences share = await SharedPreferences.getInstance();
    share.setString("email", email);
    if (user != null) {
      // SnackBar snack = const SnackBar(
      // content: Center(child: Text("ًYou are Logged in")),
      // duration: Duration(seconds: 3),);
      // ScaffoldMessenger.of(context).showSnackBar(snack);
      // print("Logged");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const second()),
      );
      SnackBar snack = const SnackBar(
      content: Center(child: Text("ًYou are Logged in")), 
      duration: Duration(seconds: 3),);
      ScaffoldMessenger.of(context).showSnackBar(snack);
      print("Logged");

    }else{
      SnackBar snack = const SnackBar(
      content: Center(child: Text("ًWrong Email or Password")),
      duration: Duration(seconds: 3),);
      ScaffoldMessenger.of(context).showSnackBar(snack);

    }
  }
}
