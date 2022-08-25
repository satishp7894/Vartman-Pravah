// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:internet_file/internet_file.dart';
// import 'package:pdfx/pdfx.dart';


class PDFScreeen extends StatefulWidget {
  const PDFScreeen({Key? key}) : super(key: key);

  @override
  State<PDFScreeen>  createState() => _PDFScreeenState();
}

class _PDFScreeenState extends State<PDFScreeen> {
  // PDFDocument? doc;
  // bool _isLoading = true;
  bool _isLoading = true;
   PDFDocument? _pdf;


  @override
  void initState() {
    // initPdf();


    super.initState();
  }
  void _loadFile(String pdfLink) async {
    // Load the pdf file from the internet
    _pdf = await PDFDocument.fromURL(
        pdfLink);

    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    // final String pdfLink =
    // ModalRoute.of(context)!.settings.arguments as String;

    dynamic argumentData = Get.arguments;
    if(_isLoading == true){
      _loadFile(argumentData[0]['pdfPath']);
      print("pdfLink ${argumentData[0]['pdfPath']}");
      print("title ${argumentData[1]['title']}");

    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(onTap:(){
          Get.back();
        },child: Icon(Icons.arrow_back,color: Colors.red,)),
        title:  Text(argumentData[1]['title'],style: TextStyle(color: Colors.red),),

      ),
      body: body(),
    );
  }

  body() {
    // return PdfView(
    //   controller: pdfController,
    // );
    return Center(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.red))
            : PDFViewer(
            showPicker : false,

            document: _pdf!));

    // return Center(
    //     child: _isLoading
    //     ? const Center(child: CircularProgressIndicator())
    // : PDFViewer(document: doc!));
  }

   initPdf() async {

    // Load from assets
    // doc = await PDFDocument.fromAsset('assets/pdf/sample.pdf');

// Load from URL
//     doc = await PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf');
//     setState(() => _isLoading = false);


// Load from file
//     File file  = File('...');
//     PDFDocument doc = await PDFDocument.fromFile(file);
  }
}
