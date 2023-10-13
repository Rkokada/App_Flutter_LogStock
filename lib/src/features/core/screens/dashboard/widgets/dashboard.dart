import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logstock/rt_db_teste/fetch_data.dart';
import 'package:logstock/src/constants/colors.dart';
import 'package:logstock/src/constants/sizes.dart';
import 'package:logstock/src/features/authentication/screens/login/login_screen.dart';
import 'package:logstock/src/login_teste/user_model.dart';

import '../../../../../../rt_db_teste/teste_reserva.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    //-----CONECTAR COM BANCO DE DADOS CLOUD_FIRESTORE E CRIAR UM BANCO DE USUARIOS------//
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());

      ///--------FIM DO BANCO DE DADOS --------------------
      horaAtual;
      setState(() {
        horaAtual;
      });
    });
  }

  String horaAtual = DateFormat('Hm').format(DateTime.now());

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  Widget build(BuildContext context) {
    horaAtual;
    return RefreshIndicator(
      onRefresh: _reloadRefresh,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.grey,
          ),
          appBar: AppBar(
              elevation: 0,
              foregroundColor: Colors.black,
              title: TextButton(
                child: Text(
                  'Stock',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    print('stock clicado');
                  });
                },
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20, top: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tCardBgColor),
                  child: IconButton(
                    onPressed: () {
                      logout(context);
                    },
                    icon: Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.red,
                      size: 26,
                    ),
                  ),
                ),
              ]),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(tDashboardPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-----CODIGO PARA IDENTIFICAR O USUARIO LOGADO -------------------------------------------//
                    Row(
                      children: [
                        Text(
                            "${loggedInUser.firstName} ${loggedInUser.secondName}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(
                          width: 160,
                        ),
                        Text(
                          horaAtual,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${loggedInUser.email}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 102,
                        ),
                        Text(
                          ('${DateFormat('dd-MM-yyyy').format(DateTime.now())}'),
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                      width: double.infinity,
                    ),

                    SizedBox(
                      height: 5,
                      width: double.infinity,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 130,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Get.to(FetchData());
                                    });
                                  },
                                  child: Text('Listar itens')),
                            ),
                            SizedBox(
                              height: 5,
                              width: 10,
                            ),
                            SizedBox(
                              width: 130,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      // Get.to();
                                    });
                                  },
                                  child: Text('prosumexemplefile')),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(TesteReserva());
                              },
                              child: Text(' teste')),
                        ),
                        SizedBox(
                          height: 5,
                          width: 10,
                        ),
                        // SizedBox(
                        //   width: 130,
                        //   height: 50,
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         Get.to(LocationScreen());
                        //       },
                        //       child: Text('Localização')),
                        // ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> _reloadRefresh() async {
    var newRefresh =
        await Future.delayed(Duration(seconds: 1), () => Dashboard());
    setState(() {
      print('refresh acionado');
      Dashboard();
    });
  }
}
