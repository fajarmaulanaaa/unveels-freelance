import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unveels/features/skin_tone_finder/presentation/cubit/stf_cubit.dart';
import 'package:unveels/features/skin_tone_finder/presentation/models/skin_tone_model.dart';
import 'package:unveels/features/skin_tone_finder/presentation/widgets/stf_shades_widget.dart';
import 'package:unveels/shared/configs/size_config.dart';
import 'package:unveels/shared/extensions/tone_tab_parsing.dart';
import 'package:unveels/shared/widgets/webview/acces_denied_camera_widget.dart';

class StfWebviewPage extends StatefulWidget {
  const StfWebviewPage({super.key});
  @override
  State<StfWebviewPage> createState() => _StfWebviewPageState();
}

class _StfWebviewPageState extends State<StfWebviewPage> {
  InAppWebViewController? webViewController;
  bool isAllowed = false;

  String? runningState = "Waiting for data...";
  String? errorState = "Waiting for data...";
  String? resultData = "Waiting for data...";
  int? selectedIndex;
  Map<String, String> hexColorTone = {
    "cooler": "A37772",
    "lighter": "DF9F86",
    "perfect fit": "B7775E",
    "warmer": "CB8B5E",
    "darker": "8F4F36"
  };
  String selectedTone = "perfect fit";
  SkinToneModel skinToneModel = SkinToneModel();
  // ToneTypeModel toneTypeModel = ToneTypeModel();
  // SkinToneProductModel skinToneProductModel = SkinToneProductModel();
  bool isLoadingProductt = true;
  ToneTab? _selectedToneTab;
  bool _isShowShades = false;

  List<String> tabList = ["", ""];
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }

    setState(() {
      isAllowed = true;
    });
  }

  @override
  void initState() {
    requestCameraPermission();
    // initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StfCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Skin Tone"),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Open shopping cart',
              onPressed: () {
                print(context.read<StfCubit>().state.skinTone?.options?.length);
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Open shopping cart',
              onPressed: () {
                // context.read<StfCubit>().fetchSkinTone();
                _onShowShades();
              },
            ),
          ],
        ),
        body: !isAllowed
            ? const AccessDeniedCameraWidget()
            : Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: WebUri(
                            'https://skin-analysis2.unveels-frontend.pages.dev/skin-tone-finder-web')),
                    onWebViewCreated: (controller) async {
                      webViewController = controller;
                      // Listen to JavaScript handler 'flutterDataHandler'
                      webViewController?.addJavaScriptHandler(
                        handlerName: 'detectionRun',
                        callback: (args) {
                          // Handle data sent from JavaScript here
                          setState(() {
                            runningState =
                                args.isNotEmpty ? args[0] : "No data received";
                          });
                        },
                      );
                      webViewController?.addJavaScriptHandler(
                        handlerName: 'detectionResult',
                        callback: (args) {
                          // Handle data sent from JavaScript here
                          setState(() {
                            resultData =
                                args.isNotEmpty ? args[0] : "No data received";
                            print('adanihh');
                            print(resultData);
                            // {hexColor:'xxx',skinTone:'xxx'}
                            if (resultData != "No data received") {
                              final decodedData =
                                  json.decode(resultData ?? "{}");
                              if (decodedData is Map<String, dynamic> &&
                                  decodedData.containsKey('hexColor') &&
                                  decodedData.containsKey('skinType')) {
                                context
                                    .read<StfCubit>()
                                    .updateHexColor(decodedData['hexColor']);
                                context
                                    .read<StfCubit>()
                                    .updateSkinType(decodedData['skinType']);
                                context.read<StfCubit>().fetchSkinTone();
                              }
                            }

                            // getProduct(
                            //     skinToneModel.options!
                            //             .where((e) =>
                            //                 e.label.toString().toLowerCase() ==
                            //                 jsonDecode(resultData!)["skinType"]
                            //                     .toString()
                            //                     .split(' ')[0]
                            //                     .toLowerCase())
                            //             .first
                            //             .value ??
                            //         '',
                            //     toneTypeModel.options
                            //             ?.where((e) =>
                            //                 e.label?.toLowerCase() ==
                            //                 selectedTone.toLowerCase())
                            //             .first
                            //             .value ??
                            //         '');
                          });
                        },
                      );
                      webViewController?.addJavaScriptHandler(
                        handlerName: 'detectionError',
                        callback: (args) {
                          // Handle data sent from JavaScript here
                          setState(() {
                            errorState =
                                args.isNotEmpty ? args[0] : "No data received";
                          });
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
                ],
              ),
      ),
    );
  }

  Future<void> _onShowShades() async {
    // show analysis results
    setState(() {
      _isShowShades = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.only(
            bottom: 3,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                STFShadesWidget(),
              ],
            ),
          ),
        );
      },
    );

    // hide analysis results
    setState(() {
      _isShowShades = false;
    });
  }
}
