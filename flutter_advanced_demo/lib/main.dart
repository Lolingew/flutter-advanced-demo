import 'package:flutter/material.dart';
import 'package:flutter_advanced_demo_package/flutter_advanced_demo_package.dart';
import 'dart:io';
import 'dart:convert';
import 'ip.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Advanced Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Advanced Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = 'Press buttons to see result.';

  void _getIpAddr() async {
    try {
      String respond = await NetworkHandler().getRequest(
          'https://httpbin.org/ip');
      //解析json数据，data是个map
      var data = json.decode(respond);
      var ip = new Ip.fromJson(data);
      setState(() {
        _result = "ip is ${ip.origin}";
      });
      debugPrint('json string is ${json.encode(ip)}');
    } catch (e) {
      setState(() {
        _result = 'Get ip addr failed.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _result,
            ),
            FlatButton(
                onPressed: () async {
                  File file = await FileHandler().writeFileWithString("test_data", "test_file.txt");
                  if (file != null) {
                    setState(() {
                      _result = "write a file at ${file.path}.";
                    });
                  } else {
                    setState(() {
                      _result = "write file failed.";
                    });
                  }
                },
                child: Text('Write File')
            ),
            FlatButton(
              onPressed: () async {
                String data = await FileHandler().readFileAsString("test_file.txt");
                if (data != null) {
                  setState(() {
                    _result = "read file with data \"$data\".";
                  });
                } else {
                  setState(() {
                    _result = "read file failed.";
                  });
                }
              },
              child: Text('Read File')
            ),
            FlatButton(
              onPressed: () {
                _getIpAddr();
              },
              child: Text('Get IP Addr'),
            )
          ],
        ),
      )
    );
  }
}
