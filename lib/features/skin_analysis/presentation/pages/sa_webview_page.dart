import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unveels/features/skin_analysis/presentation/cubit/sa_bloc.dart';
import 'package:unveels/shared/widgets/webview/acces_denied_camera_widget.dart';
import 'dart:typed_data';

class SaWebviewPage extends StatefulWidget {
  const SaWebviewPage({super.key});

  @override
  State<SaWebviewPage> createState() => _SaWebviewPageState();
}

class _SaWebviewPageState extends State<SaWebviewPage> {
  InAppWebViewController? webViewController;
  late SaBloc _saBloc;
  Uint8List? _faceSnapshot;
  bool _isWebViewVisible = true;

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    context.read<SaBloc>().add(UpdateAllowCamera(true));
  }

  @override
  void initState() {
    requestCameraPermission();
    _saBloc = SaBloc();
    super.initState();
  }

  Future<void> captureAndHideWebView() async {
    if (webViewController != null) {
      Uint8List? snapshot = await webViewController!.takeScreenshot();
      print('ini snapshot');
      print(snapshot);
      if (snapshot != null) {
        setState(() {
          _faceSnapshot = snapshot;
          _isWebViewVisible = false; // Sembunyikan WebView
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaBloc, SaState>(builder: (context, state) {
      return Scaffold(
        body: !state.isAllowCamera
            ? const AccessDeniedCameraWidget()
            : Stack(
                children: [
                  // Tampilkan gambar hasil snapshot jika ada
                  if (_faceSnapshot != null)
                    Image.memory(
                      _faceSnapshot!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),

                  // WebView hanya akan tampil jika _isWebViewVisible true
                  if (_isWebViewVisible)
                    InAppWebView(
                      initialUrlRequest: URLRequest(
                          url: WebUri(
                              'https://skin-analysis2.unveels-frontend.pages.dev/skin-analysis')),
                      onWebViewCreated: (controller) async {
                        webViewController = controller;

                        // JavaScript handler untuk 'detectionRun'
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionRun',
                          callback: (args) {
                            print('agus');
                            print(args);
                            // Tangani data dari JavaScript di sini
                          },
                        );

                        // JavaScript handler untuk 'detectionResult'
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionResult',
                          callback: (args) async {
                            print('agus');
                            print(args);
                            if (args.isNotEmpty) {
                              print(args[0]);
                              await captureAndHideWebView(); // Ambil snapshot dan sembunyikan WebView
                            }
                          },
                        );

                        // JavaScript handler untuk 'detectionError'
                        webViewController?.addJavaScriptHandler(
                          handlerName: 'detectionError',
                          callback: (args) {
                            if (args.isNotEmpty) {
                              print(args[0]);
                            }
                          },
                        );
                      },
                      onPermissionRequest:
                          (controller, permissionRequest) async {
                        return PermissionResponse(
                            resources: permissionRequest.resources,
                            action: PermissionResponseAction.GRANT);
                      },
                    ),

                  // Loading indikator
                  if (state.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
      );
    });
  }
}
