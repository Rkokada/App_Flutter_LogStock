import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TesteReserva extends StatefulWidget {
  const TesteReserva({Key? key}) : super(key: key);

  @override
  State<TesteReserva> createState() => _TesteReservaState();
}

class _TesteReservaState extends State<TesteReserva> {
  late DatabaseReference dbRefRes;

  @override
  void initState() {
    super.initState();
    dbRefRes = FirebaseDatabase.instance.ref().child('Reserva');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserva de produto'),
      ),
      body: Center(),
    );
  }
}
