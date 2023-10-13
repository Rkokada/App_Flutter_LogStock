import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../src/constants/colors.dart';
import '../src/features/authentication/controllers/location_controller.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final userProdutoController = TextEditingController();
  final userQuantidadeController = TextEditingController();
  final userTipoController = TextEditingController();
  final userNfController = TextEditingController();
  final userDataEntradaController = TextEditingController();
  final userLocalController = TextEditingController();

  late DatabaseReference dbRef;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Estoques');
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  bool isLoading = false;
  final FocusNode node1 = FocusNode();

  @override
  Widget build(BuildContext context) {
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
            if (_formKey.currentState!.validate()) {
              Map<String, String> estoque = {
                'produto': userProdutoController.text,
                'quantidade': userQuantidadeController.text,
                'tipo': userTipoController.text,
                'nf': userNfController.text,
                'data_entrada': userDataEntradaController.text,
                'local': userLocalController.text,
              };
              userProdutoController.clear();
              userQuantidadeController.clear();
              userTipoController.clear();
              userNfController.clear();
              userDataEntradaController.clear();
              userLocalController.clear();

              dbRef.push().set(estoque);
              Fluttertoast.showToast(msg: "Cadastro realizado com sucesso !! ");
            }
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isLoading = false;
              FocusScope.of(context).requestFocus(node1);
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
              ),
      ),
    );
    final controller = Get.put(LocationController());
    late final position = controller.currentLocation;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          title: const Text(
            'Cadastrar Itens',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Cadastrando item no Firebase Realtime Database',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      focusNode: node1,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Produto não pode ser vazio");
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      controller: userProdutoController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2.0, color: tSecondaryColor),
                        ),
                        labelText: 'Produto',
                        hintText: 'Digita o nome do Item',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Quantidade não pode ser vazio");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userProdutoController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      controller: userQuantidadeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2.0, color: tSecondaryColor),
                        ),
                        labelText: 'Quantidade',
                        hintText: 'Digita a quantidade',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Tipo não pode ser vazio");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userProdutoController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      controller: userTipoController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2.0, color: tSecondaryColor),
                        ),
                        labelText: 'Tipo',
                        hintText: 'Digita o tipo do item',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Nota Fiscal não pode ser vazio");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userProdutoController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      controller: userNfController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2.0, color: tSecondaryColor),
                        ),
                        labelText: 'Nota Fiscal',
                        hintText: 'Digita a Nota Fiscal do item',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      inputFormatters: [maskFormatter],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("A data não pode ser vazia");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userProdutoController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      controller: userDataEntradaController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2.0, color: tSecondaryColor),
                        ),
                        labelText: 'Data de Entrada',
                        hintText: 'Digita a data de entrada do item',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Localização não pode ser vazio");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userProdutoController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      style: TextStyle(fontSize: 18),
                      controller: userLocalController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await controller.getCurrentLocation();
                            setState(() async {
                              await controller.getCurrentLocation();
                              userLocalController.text = (position).toString();
                              print(controller.currentLocation);
                            });
                          },
                          icon: Icon(Icons.pin_drop_outlined),
                        ),
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 2.0, color: tSecondaryColor),
                        ),
                        labelText: 'Localização',
                        hintText: 'Digita a localização do item',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    signUpButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
