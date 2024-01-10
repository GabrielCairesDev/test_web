import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ambiente de testes',
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => _printPdf(context),
            child: const Text('Imprimir'),
          ),
        ),
      ),
    );
  }

  _printPdf(BuildContext context) => Printing.layoutPdf(onLayout: (PdfPageFormat format) async => _generatePdf(format: PdfPageFormat.roll80));

  Future<Uint8List> _generatePdf({required PdfPageFormat format}) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    const double fontSize = 8.0;
    final fontRegular = await PdfGoogleFonts.interRegular();
    final fontSemiBold = await PdfGoogleFonts.interSemiBold();
    final NumberFormat moneyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final DateTime stringDateTime = DateTime.parse(DateTime.now().toString());
    final String datetimeString = DateFormat('dd/MM/yyyy - HH:mm').format(stringDateTime);
    double troco = 50.0;
    if (troco.isNegative) troco = 0;

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(0),
        pageFormat: format,
        build: (context) {
          return pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text('Chegou mercado | Pediddo #12345 | $datetimeString', style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize)),
                pw.Text('-------------------------------------------------------------', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                pw.Text('Cliente', style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize + 4)),
                pw.Text('Nome: gabriel araujo', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                pw.Text('Contato: 86 88888-8888', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                pw.Text('Endereço: ashd as dhaksj ask ak halkd hals als als dhakshkd', style: pw.TextStyle(font: fontRegular, fontSize: fontSize), softWrap: true),
                pw.Text('Complemento: aasjkdhkasjlh akjsd haskj haskjdh ask dhaskd haslk haskd haskljhjdaskhdlkad', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                pw.Text('Observação: jhaskjd hksa dkjas hdkjas hkjash dkjash dkjah dksahd ', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                pw.Text('-------------------------------------------------------------', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                pw.Text('Pedido', style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize + 4)),
                pw.Text('', style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize)),
                pw.Container(
                  width: format.width,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Qtd | Produto', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                      pw.Text('Valor Unit | Valor Total', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                    ],
                  ),
                ),
                pw.Container(
                  width: format.width,
                  child: pw.ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: pw.SizedBox(
                          width: format.width,
                          child: pw.Column(
                            children: [
                              pw.Container(
                                width: format.width,
                                child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Expanded(
                                      child: pw.RichText(
                                        text: pw.TextSpan(
                                          children: [
                                            pw.TextSpan(text: '5  ', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                                            pw.TextSpan(text: 'sadhaskhdk sakd haskdh askd haskdh kas', style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                      children: [
                                        pw.Text('${moneyFormat.format(50.0)}   ', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                                        pw.Text(moneyFormat.format(23.00), style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              pw.Text('-------------------------------------------------------------', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                pw.Text('Pagamento\n', style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize + 4)),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      '[ X ] Cartão',
                      style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize),
                    ),
                    pw.Text(
                      '[  ] Dinheiro',
                      style: pw.TextStyle(font: fontRegular, fontSize: fontSize),
                    ),
                    pw.Text(
                      '[  ] Pix',
                      style: pw.TextStyle(font: fontRegular, fontSize: fontSize),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Entrega\n${99.0}', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                    pw.Text('Desconto\n${15.0}', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                    pw.Text('Troco para\n${30.0}', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                    pw.Text('Valor troco\n${moneyFormat.format(troco)}', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                  ],
                ),
                pw.Text('-------------------------------------------------------------', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Valor Total:', style: pw.TextStyle(font: fontRegular, fontSize: fontSize)),
                    pw.Text(moneyFormat.format(200.0), style: pw.TextStyle(font: fontSemiBold, fontSize: fontSize + 4)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
