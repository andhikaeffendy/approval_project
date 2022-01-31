import 'dart:io';
import 'package:approvalproject/globals/variable.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Downloader {
  static Future<String> downloadFile(String uri, String filename, {Function onProgress, Function onDone, Function onFail}) async {
    String dir = "";
    if(Platform.isIOS){
      dir = (await getApplicationDocumentsDirectory()).path;
    } else {
      dir = (await getExternalStorageDirectory()).path;
    }
    print("$dir/$filename");
    bool exists = await File("$dir/$filename").exists();
    if(exists){
      if(onDone != null) onDone("$dir/$filename");
      return "$dir/$filename";
    }

    Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + globalUserDetails.idToken;
    try {
      await dio.download(
        uri,
        "$dir/$filename",
        deleteOnError: true,
        onReceiveProgress: (received, total){
          print('${received.toString()}/${total.toString()}');
          if(onProgress!=null)onProgress(received, total);
        },
      );
      if(onDone != null) onDone("$dir/$filename");
      return "$dir/$filename";
    } on DioError catch (e) {
      if (e.response != null ) {
        print(e.message);
        return null;
      } else {
        print(e.message);
        return null;
      }
    } on FileSystemException catch(e){
      print(e.message);
    }
  }

  static String getFileName(String fileUrl){
    if(fileUrl == null || fileUrl.isEmpty) return "";
    List<String> urls = fileUrl.split("/");
    return urls[urls.length-1];
  }
}