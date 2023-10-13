import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFMaker {
  Future<Uint8List> generatePDF(List<Map<String, dynamic>> items) async {
    final pw.Document pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
            level: 0,
            child: pw.Text("Itens do Realtime Database"),
          ),
          pw.Table.fromTextArray(context: context, data: [
            <String>["Key", "Value"],
            ...items
                .map((item) => [item.keys.first, item.values.first.toString()]),
          ]),
        ];
      },
    ));

    final Uint8List result = await pdf.save();
    return result;
  }
}
