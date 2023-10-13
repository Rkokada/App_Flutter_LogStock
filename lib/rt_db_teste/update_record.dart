import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../src/constants/colors.dart';
import '../src/features/authentication/controllers/location_controller.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.estoqueKey}) : super(key: key);

  final String estoqueKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
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
    dbRef = FirebaseDatabase.instance.ref().child('Estoques');
    getStudentData();
    //////
    final controller = Get.put(LocationController());
    final localAtual = controller.currentLocation;
    userProdutoController.addListener(() => setState(() {}));
    userQuantidadeController.addListener(() => setState(() {}));
    userTipoController.addListener(() => setState(() {}));
    userNfController.addListener(() => setState(() {}));
    userDataEntradaController.addListener(() => setState(() {}));
    userLocalController.addListener(() => setState(() {}));

    ///

    super.initState();
  }

  void getStudentData() async {
    DataSnapshot snapshot = await dbRef.child(widget.estoqueKey).get();

    Map estoque = snapshot.value as Map;

    userProdutoController.text = estoque['produto'];
    userQuantidadeController.text = estoque['quantidade'];
    userTipoController.text = estoque['tipo'];
    userNfController.text = estoque['nf'];
    userDataEntradaController.text = estoque['data_entrada'];
    userLocalController.text = estoque['local'];
  }

  var maskFormatter =  MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationController());

    final update = Material(
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

              dbRef.child(widget.estoqueKey).update(estoque);
              // .then((value) => {Navigator.pop(context)});
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  Navigator.pop(context);
                });
              });

              Fluttertoast.showToast(msg: "Item atualizado com sucesso !! ");
            }
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
                "Atualizar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );

    return SafeArea(
      child: GetBuilder<LocationController>(
          init: LocationController(),
          builder: (controller) {
            late final position = controller.currentLocation;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                foregroundColor: Colors.black,
                title: const Text(
                  'Atualizar Item',
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
                            'Atualizando dados no Firebase Realtime Database',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Produto não pode ser vazio");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userProdutoController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 18),
                            controller: userProdutoController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: userProdutoController.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      onPressed: () =>
                                          userProdutoController.clear(),
                                      icon: Icon(Icons.close),
                                    ),
                              hintStyle: TextStyle(fontSize: 18),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor),
                              ),
                              labelText: 'Produto',
                              hintText: 'Digita o nome do produto',
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
                              suffixIcon: userQuantidadeController.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      onPressed: () =>
                                          userQuantidadeController.clear(),
                                      icon: Icon(Icons.close),
                                    ),
                              hintStyle: TextStyle(fontSize: 18),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor),
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
                              suffixIcon: userTipoController.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      onPressed: () =>
                                          userTipoController.clear(),
                                      icon: Icon(Icons.close),
                                    ),
                              hintStyle: TextStyle(fontSize: 18),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor),
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
                              suffixIcon: userNfController.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      onPressed: () => userNfController.clear(),
                                      icon: Icon(Icons.close),
                                    ),
                              hintStyle: TextStyle(fontSize: 18),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor),
                              ),
                              labelText: 'Nota Fiscal',
                              hintText: 'Digita a Nota Fiscal do item',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              maskFormatter
                            ],
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 18),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor),
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
                                      userLocalController.text =
                                          (position).toString();
                                      print(controller.currentLocation);
                                    });
                                  },
                                  icon: Icon(Icons.pin_drop_outlined),
                                ),
                                hintStyle: TextStyle(fontSize: 18),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 2.0, color: tSecondaryColor),
                                ),
                                labelText: 'Localização',
                                hintText: 'Clica para Localização'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          update,
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
