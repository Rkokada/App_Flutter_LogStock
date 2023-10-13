import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logstock/src/constants/colors.dart';
import 'package:logstock/src/constants/text_strings.dart';
import 'package:logstock/src/features/core/screens/dashboard/widgets/dashboard.dart';
import 'package:logstock/src/login_teste/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final tHeaderCadastro = Text(
      'Cadastro de Usuário',
      style: GoogleFonts.montserrat(
          fontSize: 27, color: Colors.deepPurple, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
    //first name field
    final firstNameField = TextFormField(
        textCapitalization: TextCapitalization.words,
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Nome não pode ser vazio");
          }
          if (!regex.hasMatch(value)) {
            return ("Inseri nome válido(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person_outline),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "Nome",
          labelText: tFirstName,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: tSecondaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        textCapitalization: TextCapitalization.words,
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Sobrenome não pode ser vazio");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle_outlined),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "Sobrenome",
          labelText: tLastName,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2.0, color: tSecondaryColor),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Por favor inserir seu E-mail.");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Por favor inserir um e-mail válido ");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail_outline_rounded),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "E-mail",
          labelText: tEmail,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2.0, color: tSecondaryColor),
          ),
        ));
    //phone field
    final phoneField = TextFormField(
        autofocus: false,
        controller: phoneEditingController,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_outlined),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "Telefone",
          labelText: tPhone,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2.0, color: tSecondaryColor),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Necessário cadastrar uma senha.");
          }
          if (!regex.hasMatch(value)) {
            return ("Digita uma senha válida.(Min. 6 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key_outlined),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "Senha",
          labelText: tPassword,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2.0, color: tSecondaryColor),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Senha não confere!";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key_outlined),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintText: "Confirmar Senha",
          labelText: tConfirmPassword,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2.0, color: tSecondaryColor),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      color: tSecondaryColor,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            setState(() {
              isLoading = true;
              signUp(
                  emailEditingController.text, passwordEditingController.text);
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
                  "Cadastrar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: tSecondaryColor),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                          height: 180,
                          child: Image.asset(
                            "assets/images/profile/profileImage.png",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 10),
                      tHeaderCadastro,
                      SizedBox(height: 25),
                      firstNameField,
                      SizedBox(height: 20),
                      secondNameField,
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 20),
                      phoneField,
                      SizedBox(height: 20),
                      passwordField,
                      SizedBox(height: 20),
                      confirmPasswordField,
                      SizedBox(height: 20),
                      signUpButton,
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            // ignore: invalid_return_type_for_catch_error
            .catchError((e) => Fluttertoast.showToast(msg: e!.message));
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;

    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.phone = phoneEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Cadastro realizado com sucesso :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
  }
}
