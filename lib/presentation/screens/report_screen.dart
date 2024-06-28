/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> generatePdf() async {
  final pdf = Document();
  /*final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
  final ttf = pdf.Font.ttf(fontData);*/

  /*pdf.addPage(
    MultiPage(
    //  pageFormat: PdfPageFormat.43
    ),
  );*/

  final directory = await getExternalStorageDirectory();
  final filePath = '${directory!.path}/example.pdf';
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  return filePath;
}

class PdfCreatorWidget extends StatefulWidget {
  @override
  _PdfCreatorWidgetState createState() => _PdfCreatorWidgetState();
}

class _PdfCreatorWidgetState extends State<PdfCreatorWidget> {
  late Future<String> _pdfPath;

  @override
  void initState() {
    super.initState();
    _pdfPath = generatePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate and View PDF')),
      body: FutureBuilder<String>(
        future: _pdfPath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No PDF generated'));
          } else {
            return SfPdfViewer.file(File(snapshot.data!));
          }
        },
      ),
    );
  }
}
*/