import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:async';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // 뒤로 가기 시 전 화면으로 이동하기 위함
  WebViewController? _webViewController;

  // 뒤로 가기 시 전 화면으로 이동하기 위함
  final Completer<WebViewController> _completerController = Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () => _goBack(context),
      child: Scaffold(
        body: SafeArea(
          child: WebView(

            // 뒤로 가기 시 전 화면으로 이동하기 위함
            onWebViewCreated: (WebViewController webViewController) {
              _completerController.future
                  .then((value) => _webViewController = value);

              _completerController.complete(webViewController);
            },

            // 접속할 Url
            initialUrl: 'https://lululalazon.com',

            // 자바스크립트 사용 여부
            javascriptMode: JavascriptMode.unrestricted,

            // 옆으로 스와이프해서 뒤로가기
            gestureNavigationEnabled: true,

            // 구글 로그인 시 정상 작동
            userAgent: "random",
          ),

        ),
      ),
    );
  }

  // 뒤로 가기 시 전 화면으로 이동하기 위함
  Future<bool> _goBack(BuildContext context) async {

    if (_webViewController == null) {
      return true;
    }

    if (await _webViewController!.canGoBack()) {
      _webViewController!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }

  }

}


