import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sign_in.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String username = "";
  String email = "";
  // Future<List<String>> list = getData();
  @override
  void initState() {
    super.initState();
    getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top:20.0 ,bottom: 20.0),
          child: SizedBox(width: 300,
            child: Image.asset("assets/User.png"
            ,color: Colors.purple),
          ),
        )
        ,
        Text(email, style: TextStyle(color: Colors.orange,fontSize: 20)),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 250,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const login()),
                );
                SnackBar snack = const SnackBar(
                  content: Center(child: Text("You are Logged out")),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
              },
              child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Sign out",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
            ),
          ),
        )
      ]),
    ));
  }

  void getData() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    username = share.getString("name")!;
    email = share.getString("email")!;
    setState(() {
      
    });
    
  }
}
