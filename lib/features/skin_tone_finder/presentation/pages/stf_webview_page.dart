import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unveels/features/skin_tone_finder/presentation/cubit/stf_bloc.dart';
import 'package:unveels/features/skin_tone_finder/presentation/widgets/stf_shades_widget.dart';
import 'package:unveels/shared/extensions/context_parsing.dart';
import 'package:unveels/shared/widgets/buttons/button_widget.dart';
import 'package:unveels/shared/widgets/lives/bottom_copyright_widget.dart';
import 'package:unveels/shared/widgets/webview/acces_denied_camera_widget.dart';
// import 'package:url_launcher/url_launcher.dart';

class StfWebviewPage extends StatefulWidget {
  const StfWebviewPage({super.key});

  @override
  State<StfWebviewPage> createState() => _StfWebviewPageState();
}

class _StfWebviewPageState extends State<StfWebviewPage> {
  InAppWebViewController? webViewController;

  // void _launchURL(String? url) async {
  //   if (!await launch(url!)) throw 'Could not launch $url';
  // }
  bool _isShowShades = false;
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    context.read<StfBloc>().add(UpdateAllowCamera(true));
  }

  @override
  void initState() {
    requestCameraPermission();
    super.initState();
  }

  @override
  void dispose() {
// update semua sesuai initial

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StfBloc, StfState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Skin Tone Finder'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<StfBloc>().add(UpdateHexColor(''));
              },
            ),
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.shopping_cart),
            //     tooltip: 'Open shopping cart',
            //     onPressed: () {
            //       print('halo');
            //       print(context.read<StfBloc>().state.productData);
            //       // print(context.read<StfBloc>().state.selectToneSkinId);
            //     },
            //   ),
            //   IconButton(
            //     icon: const Icon(Icons.shopping_cart),
            //     tooltip: 'Open shopping cart',
            //     onPressed: () {
            //       // context.read<StfCubit>().fetchSkinTone();
            //       context.read<StfBloc>().add(FetchProduct());
            //     },
            //   ),
            // ],
          ),
          body: !state.isAllowCamera
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
                            // setState(() {
                            //   runningState =
                            //       args.isNotEmpty ? args[0] : "No data received";
                            // });
                          },
                        );
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionResult',
                          callback: (args) {
                            // Handle data sent from JavaScript here
                            if (args.isNotEmpty) {
                              print(args[0]);
                              final decodedData = json.decode(args[0] ?? "{}");
                              context
                                  .read<StfBloc>()
                                  .add(UpdateHexColor(decodedData['hexColor']));
                              context
                                  .read<StfBloc>()
                                  .add(UpdateSkinType(decodedData['skinType']));
                              context.read<StfBloc>().add(FetchSkinTone());
                              context.read<StfBloc>().add(FetchToneType());
                              context.read<StfBloc>().add(FetchProduct());
                              _onShowShades();
                            }
                          },
                        );
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionError',
                          callback: (args) {
                            // Handle data sent from JavaScript here
                            // setState(() {
                            //   errorState = args.isNotEmpty
                            //       ? args[0]
                            //       : "No data received";
                            // });
                          },
                        );
                      },
                      onLoadStart: (controller, url) async {
                        // log('loading : $url');
                      },
                      onPermissionRequest:
                          (controller, permissionRequest) async {
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

                    //loading
                    state.isLoading
                        ? const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox(),

                    state.hexColor != ''
                        ? _isShowShades
                            ? const SizedBox.shrink()
                            : BottomCopyrightWidget(
                                showText: false,
                                child: Column(
                                  children: [
                                    ButtonWidget(
                                      text: 'SHOW SHADES',
                                      width: context.width / 2,
                                      backgroundColor: Colors.black,
                                      onTap: _onShowShades,
                                    ),
                                  ],
                                ),
                              )
                        : const SizedBox()
                  ],
                ),
        );
      },
    );
  }

  Future<void> _onShowShades() async {
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
            bottom: 10,
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
    setState(() {
      _isShowShades = false;
    });
  }
}
