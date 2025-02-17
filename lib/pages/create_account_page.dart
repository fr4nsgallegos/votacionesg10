import 'package:appvotacionesg10/pages/create_account_page.dart';
import 'package:appvotacionesg10/pages/home_page.dart';
import 'package:appvotacionesg10/widgets/field_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String mapErrorAuth(String errorMessage) {
    if (errorMessage.contains("email-already-in-use")) {
      return "La dirección de correo ya esta en uso";
    } else if (errorMessage.contains("invalid-email")) {
      return "El correo no es válido";
    } else if (errorMessage.contains("weak-password")) {
      return "La contraseña no cumple con los estándares";
    } else {
      // return "Ocurrio un error al crear la cuenta";
      return errorMessage;
    }
  }

  Future<void> _createAccountEmailPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      String uid = userCredential.user!
          .uid; //capturando el uid que se creo al momento de registrar mi cuenta

      try {
        await _firestore.collection("users").doc(uid).set({
          "email": _emailController.text,
          "name": _nameController.text,
          "lastname": _lastnameController.text,
          "phone": _phoneController.text,
          "createdAt": FieldValue.serverTimestamp(),
        });
        // print(userCredential);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (Route<dynamic> route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            behavior: SnackBarBehavior.floating,
            content: Text("Usuario registrado exitosamente"),
          ),
        );
      } catch (firestoreError) {
        //Si falla la inserción en Firestore, se debe eliminar el usuario que se ha creado por auth
        await userCredential.user!.delete();
        throw Exception(
            "Error al insertar los datos en firestoe: $firestoreError");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(
            mapErrorAuth(
              e.toString(),
            ),
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
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   _firestore.collection("users").get().then((e) {
        //     print(e);
        //   });
        // }),
        resizeToAvoidBottomInset: true,
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: heigthScreen / 7,
                          color: Color(0xff173D31),
                          padding: EdgeInsets.all(24),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.orange,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Text(
                                "Crear cuenta",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    height: heigthScreen - 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FieldBox(
                            title: "Nombre",
                            hint: "Ingresa el nombre",
                            controller: _nameController),
                        FieldBox(
                          title: "Apellido",
                          hint: "Ingresa tu apellido",
                          controller: _lastnameController,
                        ),
                        FieldBox(
                          title: "Número de celular",
                          hint: "Ingresa el número de celular",
                          controller: _phoneController,
                        ),
                        FieldBox(
                            title: "Correo",
                            hint: "Ingresa tu correo",
                            controller: _emailController),
                        FieldBox(
                          title: "Contraseña",
                          hint: "Ingresa la contraseña",
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              _createAccountEmailPassword(context);
                            },
                            child: Text(
                              "CREAR CUENTA",
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
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Ya tienes una cuenta?"),
                            SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "INICIA SESIÓN",
                                style: TextStyle(
                                    color: Color(0xff173D31),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
