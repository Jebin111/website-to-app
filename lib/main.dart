import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _webViewController;
  double webProgress =0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: ()async{
            if (await _webViewController.canGoBack()){
              _webViewController.goBack();
              return false;
            }
            else {
              return true;
            }
          },
          child: Column(
            children: [
              webProgress<1 ? SizedBox(
                height: 5,
                child: LinearProgressIndicator(
                  value: webProgress,
                  color: Colors.red,
                  backgroundColor: Colors.black,
                ),
              ):const SizedBox(),
              Expanded(
                child: WebView(
                  initialUrl: "https://jebinjs.blogspot.com",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController c){
                    _webViewController=c;
                  },
                  onProgress: (progress)=>setState(() {
                    webProgress=progress/100;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
