import 'dart:io';

import 'package:approvalproject/globals/downloader.dart';
import 'package:approvalproject/globals/variable.dart';
import 'package:approvalproject/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DraftRequest extends StatefulWidget {
  final String approvalFormId;

  const DraftRequest({Key key, this.approvalFormId}) : super(key: key);
  @override
  _DraftRequestState createState() => _DraftRequestState(approvalFormId);
}

class _DraftRequestState extends State<DraftRequest> {
  String approvalFormId;
  String url;

  _DraftRequestState(this.approvalFormId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = domain + "/api/v1/pdf_form.pdf?form_id=$approvalFormId";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context, rootNavigator: true).pop();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Preview'),
        ),
        body: FutureBuilder(
          future: downloadFile(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
              return PDFView(
                enableSwipe: true,
                autoSpacing: false,
                pageFling: false,
                fitPolicy: FitPolicy.WIDTH,
                filePath: snapshot.data,
              );
            } else
            return Center(child: Text("Something Wrong"));
          },
        ),
      ),

    );
  }

  Future<String> downloadFile()async{
    String fileDownloadPath = await Downloader.downloadFile(url, "$approvalFormId.pdf");
    bool downloadDone = await File(fileDownloadPath).exists();
    return downloadDone ? fileDownloadPath : null;
  }

  showCircular(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
    );
  }

}
