import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logstock/rt_db_teste/update_record.dart';

import '../src/constants/colors.dart';
import 'fab_menu_button.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Estoques');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Estoques');

  final searchFilter = TextEditingController();

  final refe = '';

  @override
  void initState() {
    FirebaseDatabase.instance.ref().child('Estoques');

    // searchFilter.text;
    

    // print(totalItens);
    super.initState();
  }

////********** LISTA DE ESTOQUE GERADA ****************************** */
  Widget listItem({required Map estoque}) {
    showAlertDialogDelete(BuildContext context) {
      Widget cancelaButton = TextButton(
        child: Text("Cancelar",
            style: TextStyle(
              fontSize: 18,
            )),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      Widget continuaButton = TextButton(
        child: Text("Confirmar",
            style: TextStyle(
              fontSize: 18,
            )),
        onPressed: () {
          setState(() {
            reference.child(estoque['key']).remove();
            Fluttertoast.showToast(
                msg: "Item excluído com sucesso !! ",
                backgroundColor: tSecondaryColor);
            Navigator.pop(context);
          });
        },
      );
      //configura o AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(
          "Exclusão de item !!",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        content: Text('Deseja excluir o item ' + estoque['produto'] + '?',
            style: TextStyle(
              fontSize: 20,
            )),
        actions: [
          cancelaButton,
          continuaButton,
        ],
      );
      //exibe o diálogo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(7),
      height: 210,
      color: Colors.grey[350],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'SKU: ' + estoque['key'],
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UpdateRecord(
                                estoqueKey: estoque['key'],
                              )));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      size: 27,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAlertDialogDelete(context);
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 25,
                      color: Colors.red[700],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Produto: ' + estoque['produto'],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Quantidade: ' + estoque['quantidade'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Tipo: ' + estoque['tipo'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Nota Fiscal: ' + estoque['nf'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Data Entrada: ' + estoque['data_entrada'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Localização: ' + estoque['local'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  final FocusNode node1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    // searchFilter.text = 'Estoque';
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FabMenuButton(),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                focusNode: node1,
                style: TextStyle(fontSize: 20),
                controller: searchFilter,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_outlined, size: 22),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search_outlined,
                          size: 25,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          setState(
                              () => FocusScope.of(context).requestFocus(node1));
                        }),
                    contentPadding: EdgeInsets.fromLTRB(5, 3, 10, 5),
                    labelText: '                Estoque',
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                    // hintText: '                 Estoque',
                    // hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 2.0, color: tSecondaryColor),
                    )),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
            Text(refe),
            Expanded(
              child: FirebaseAnimatedList(
                  defaultChild: Center(
                    child: CircularProgressIndicator(
                      color: tSecondaryColor,
                    ),
                  ),
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    final stock = snapshot.value.toString();
                    if (searchFilter.text.isEmpty) {
                      Map estoque = snapshot.value as Map;
                      estoque['key'] = snapshot.key;
                      return listItem(estoque: estoque);
                    } else if (stock.toLowerCase().contains(
                        searchFilter.text.toLowerCase().toLowerCase())) {
                      Map estoque = snapshot.value as Map;
                      estoque[stock] = snapshot.key;
                      print(stock);

                      return listItem(estoque: estoque);
                    } else {
                      return SizedBox(child: Container());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
