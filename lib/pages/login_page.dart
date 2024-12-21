import 'package:appvotacionesg10/pages/create_account_page.dart';
import 'package:appvotacionesg10/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;
      }
    } catch (e) {}
  }

  String mapErrorAuth(String errorMessage) {
    if (errorMessage.contains("invalid-credential")) {
      return "Usuario o contraseña incorrectos";
    } else if (errorMessage.contains("invalid-email")) {
      return "El correo no es válido";
    } else {
      return "Ocurrio un error al crear la cuenta";
    }
  }

  Future<void> _loginWithEmailPassword(BuildContext context) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (Route<dynamic> route) => false,
        );
      });
    } catch (e) {
      print("...........................................");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          behavior: SnackBarBehavior.floating,
          content: Text(
            mapErrorAuth(e.toString()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double heigthScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: heigthScreen,
              width: widthScreen,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff173D31),
                    Colors.white,
                  ],
                  stops: [0.5, 0.5],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: heigthScreen / 2 - 24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/friends.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: heigthScreen / 2 - 24,
                        color: Color(0xff173D31).withOpacity(0.9),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xffFCB635),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.asset("assets/icons/icon.png"),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Bienvenido",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  height: heigthScreen / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        cursorColor: Colors.orange,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            labelText: "Correo electrónico",
                            hintText: "Ingresa el correo",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange))),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        cursorColor: Colors.orange,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                          hintText: "Ingresa la contraseña",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (value) {}),
                              Text(
                                "Recuérdame",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text("¿Olvidaste la contraseña?"))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            _loginWithEmailPassword(context);
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff6F9575),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("¿No tienes una cuenta?"),
                          SizedBox(
                            width: 8,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAccountPage(),
                                ),
                              );
                            },
                            child: Text(
                              "CREA UNA",
                              style: TextStyle(
                                  color: Color(0xff173D31),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Ó inicia sesión con"),
                          SizedBox(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(8)),
                                onPressed: () {
                                  _signInWithGoogle(context);
                                },
                                child: Image.asset(
                                  "assets/icons/google.png",
                                  height: 30,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
