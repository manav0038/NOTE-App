import 'package:firebase_1/ForgetPassword.dart';
import 'package:firebase_1/MainScreen.dart';
import 'package:firebase_1/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login Screen"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/baground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Container(
                height: 100.0,
                alignment: Alignment.center,
                child: Image.asset('assets/icon.png'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginEmailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.black),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginPasswordController,
                  style: TextStyle(color: Colors.black),
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ForgetPasswordScreen());
                },
                child: Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Forget Password"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  var loginEmail = loginEmailController.text.trim();
                  var loginPassword = loginPasswordController.text.trim();
                  try {
                    final User? firebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: loginEmail, password: loginPassword))
                        .user;
                    if (firebaseUser != null) {
                      Get.to(() => MainScreen());
                    } else {
                      print("Check email and password");
                    }
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUp());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Card(
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Don't have an account? Sign Up"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 230.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
