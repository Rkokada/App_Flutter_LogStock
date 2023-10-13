import 'package:flutter/material.dart';

import '../api/pdf_api.dart';
import '../api/pdf_invoice_api.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import '../widgets/button_widget.dart';
import '../widgets/title_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Gerar Fatura',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Fatura PDF',
                  onClicked: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(Duration(days: 7));

                    final invoice = Invoice(
                      supplier: Supplier(
                        name: 'Ramond Rocha',
                        address: 'Rua Arinda Nogueira,148 Botafogo Macaé RJ',
                        paymentInfo: 'https://paypal.me/ramondrocha',
                      ),
                      customer: Customer(
                        name: 'Quitanda do Seu Tóba',
                        address: 'Rua do Rego, Buraco fundo',
                      ),
                      info: InvoiceInfo(
                        pix: 'PIX 09973985745',
                        date: date,
                        dueDate: dueDate,
                        description: 'Descrição:',
                        number: '${DateTime.now().year}',
                      ),
                      items: [
                        InvoiceItem(
                          description: 'Café',
                          date: DateTime.now(),
                          quantity: 3,
                          vat: 0.08,
                          unitPrice: 5.99,
                        ),
                        InvoiceItem(
                          description: 'Água',
                          date: DateTime.now(),
                          quantity: 1,
                          vat: 0.08,
                          unitPrice: 3.80,
                        ),
                        InvoiceItem(
                          description: 'Laranja',
                          date: DateTime.now(),
                          quantity: 3,
                          vat: 0.08,
                          unitPrice: 2.99,
                        ),
                        InvoiceItem(
                          description: 'Maçã',
                          date: DateTime.now(),
                          quantity: 8,
                          vat: 0.08,
                          unitPrice: 3.99,
                        ),
                        InvoiceItem(
                          description: 'Manga',
                          date: DateTime.now(),
                          quantity: 1,
                          vat: 0.08,
                          unitPrice: 1.59,
                        ),
                        InvoiceItem(
                          description: 'Melancia',
                          date: DateTime.now(),
                          quantity: 5,
                          vat: 0.08,
                          unitPrice: 0.99,
                        ),
                        InvoiceItem(
                          description: 'Limão',
                          date: DateTime.now(),
                          quantity: 4,
                          vat: 0.08,
                          unitPrice: 1.29,
                        ),
                      ],
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
