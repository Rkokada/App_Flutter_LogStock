import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logstock/src/constants/colors.dart';
import 'package:logstock/src/constants/text_strings.dart';
import 'package:logstock/src/login_teste/registration_screen.dart';

import '../../../../common_widgets/fade_in_animation/animation_design.dart';
import '../../../../common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import '../../../../common_widgets/fade_in_animation/fade_in_animation_model.dart';
import '../../../core/screens/dashboard/widgets/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  bool isLoading = false;

  // string for displaying the error Message
  String? errorMessage;
  String password = '';
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Digitar um E-mail válido!");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Por favor inseri um e-mail válido");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: tSecondaryColor),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "Email",
          labelText: tEmail,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: isPasswordVisible,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Favor digitar a senha corretamente!");
          }
          if (!regex.hasMatch(value)) {
            return ("Inseri um senha Válida (Min. 6 Character)");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible),
            icon: isPasswordVisible
                ? Icon(Icons.visibility_off_outlined)
                : Icon(Icons.visibility_outlined),
            color: tSecondaryColor,
          ),
          prefixIcon: Icon(Icons.vpn_key, color: tSecondaryColor),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "Senha",
          labelText: tPassword,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2.0, color: tSecondaryColor),
          ),
        ));

    final loginButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      color: tSecondaryColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          setState(() {
            isLoading = true;
            signIn(emailController.text, passwordController.text);
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              isLoading = false;
            });
          });
        },
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                "Login".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          TFadeInAnimation(
            durationInMs: 1200,
            animate: TAnimatePosition(
              bottomAfter: 30,
              bottomBefore: -20,
              leftAfter: 10,
              leftBefore: 10,
              rightAfter: 10,
              rightBefore: 10,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 120,
                          child: Image.asset(
                              "assets/images/profile/profileImage.png",
                              fit: BoxFit.contain),
                        ),
                        SizedBox(height: 45),
                        emailField,
                        SizedBox(height: 25),
                        passwordField,
                        SizedBox(height: 35),
                        loginButton,
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Não tem uma conta? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: Text(
                                  "Cadastre-se !",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
        // )
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login realizado com sucesso"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Dashboard())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Seu e-mail não foi inserido corretamente.";

            break;
          case "wrong-password":
            errorMessage = "Senha incorreta. Tente novamente";
            break;
          case "user-not-found":
            errorMessage = "Usuário não encontrado, ou já existe.";
            break;
          case "user-disabled":
            errorMessage = "Usuário foi desativado.";
            break;
          case "too-many-requests":
            errorMessage =
                "Usou muitas requisições, aguarde um momento por favor.";
            break;
          case "operation-not-allowed":
            errorMessage = "Cadastro com e-mail e senha não disponível.";
            break;
          default:
            errorMessage = "Aconteceu algum erro inesperado!";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
