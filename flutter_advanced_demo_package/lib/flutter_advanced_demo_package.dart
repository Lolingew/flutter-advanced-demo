library flutter_advanced_demo_package;

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

/// A file handler.
class FileHandler {
  Future<String> readFileAsString(String fileName) async {
    try {
      File file = await getLocalFile(fileName);
      return file.readAsString();
    } on FileSystemException {
      return null;
    }
  }

  Future<File> writeFileWithString(String data, String fileName) async {
    File file = await getLocalFile(fileName);
    await file.writeAsString(data);
    return file;
  }

  Future<File> getLocalFile(String fileName) async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/$fileName');
  }
}

class NetworkHandler {
  Future<String> getRequest(String url) async {
    //建立一个HttpClient
    var httpClient = new HttpClient();

    String result;
    try {
      //发送request
      var request = await httpClient.getUrl(Uri.parse(url));
      //接收response
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        //获取response中的json数据
        result = await response.transform(utf8.decoder).join();
      } else {
        //字符串内用${}夹带变量，和kotlin用法一致
        result =
        'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
    return result;
  }
}