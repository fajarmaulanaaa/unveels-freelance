import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PfWebviewPage extends StatefulWidget {
  const PfWebviewPage({super.key});

  @override
  State<PfWebviewPage> createState() => _PfWebviewPageState();
}

class _PfWebviewPageState extends State<PfWebviewPage> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: WebUri(
                'https://skin-analysis2.unveels-frontend.pages.dev/personality-finder')),
        onWebViewCreated: (controller) async {
          webViewController = controller;
          // Listen to JavaScript handler 'flutterDataHandler'
          webViewController?.addJavaScriptHandler(
            handlerName: 'detectionRun',
            callback: (args) {
              // Handle data sent from JavaScript here
              setState(() {
                // runningState =
                //     args.isNotEmpty ? args[0] : "No data received";
              });
            },
          );
          webViewController?.addJavaScriptHandler(
            handlerName: 'detectionResult',
            callback: (args) {
              // final resultData = args.isNotEmpty ? args[0] : "No data received";

              print('saaassas');
              print(args.isNotEmpty ? args[0] : 'asda');
              // Handle data sent from JavaScript here
              // setState(() {
              //   resultData =
              //       args.isNotEmpty ? args[0] : "No data received";

              //   print(resultData);

              //   getProduct(
              //       skinToneModel.options!
              //               .where((e) =>
              //                   e.label.toString().toLowerCase() ==
              //                   jsonDecode(resultData!)["skinType"]
              //                       .toString()
              //                       .split(' ')[0]
              //                       .toLowerCase())
              //               .first
              //               .value ??
              //           '',
              //       toneTypeModel.options
              //               ?.where((e) =>
              //                   e.label?.toLowerCase() ==
              //                   selectedTone.toLowerCase())
              //               .first
              //               .value ??
              //           '');
              // });
            },
          );
          webViewController?.addJavaScriptHandler(
            handlerName: 'detectionError',
            callback: (args) {
              // Handle data sent from JavaScript here
              // setState(() {
              //   errorState =
              //       args.isNotEmpty ? args[0] : "No data received";
              // });
            },
          );
        },
        onLoadStart: (controller, url) async {
          // log('loading : $url');
        },
        onPermissionRequest: (controller, permissionRequest) async {
          return PermissionResponse(
              resources: permissionRequest.resources,
              action: PermissionResponseAction.GRANT);
        },
        // shouldOverrideUrlLoading:
        //     (controller, navigationAction) async {
        //   var uri = navigationAction.request.url!;

        //   if (![
        //     "http",
        //     "https",
        //     "file",
        //     "chrome",
        //     "data",
        //     "javascript",
        //     "about"
        //   ].contains(uri.scheme)) {
        //     if (await canLaunchUrl(uri)) {
        //       // Launch the App
        //       await launchUrl(
        //         uri,
        //       );
        //       // and cancel the request
        //       return NavigationActionPolicy.CANCEL;
        //     }
        //   }

        //   return NavigationActionPolicy.ALLOW;
        // },

        onLoadStop: (controller, url) async {},
        onProgressChanged: (controller, progress) {},
        onUpdateVisitedHistory: (controller, url, isReload) {},
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    );
  }
}
