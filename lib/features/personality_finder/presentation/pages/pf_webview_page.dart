import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:unveels/features/personality_finder/presentation/cubit/pf_bloc.dart';
import 'package:unveels/features/personality_finder/presentation/models/pf_model.dart';

import '../widgets/pf_analysis_results_widget.dart';

class PfWebviewPage extends StatefulWidget {
  const PfWebviewPage({super.key});

  @override
  State<PfWebviewPage> createState() => _PfWebviewPageState();
}

class _PfWebviewPageState extends State<PfWebviewPage> {
  InAppWebViewController? webViewController;
  bool _showAnalysisResults = false;
  bool _isLoading = false;
  String _debugMessage = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PfBloc, PfState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Personality Finder'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.print),
              //     tooltip: 'Print',
              //     onPressed: () {
              //       print(context.read<PfBloc>().state.resultPersonalityModel);
              //     },
              //   ),
              // ],
            ),
            body: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri('https://skin-analysis2.unveels-frontend.pages.dev/personality-finder-web'),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                    webViewController?.addJavaScriptHandler(
                      handlerName: 'detectionRun',
                      callback: (args) {
                        setState(() {
                          _isLoading = true;
                          _debugMessage = args.isNotEmpty ? 'Received in detectionRun: ${args[0]}' : 'No data';
                        });
                        print('Data received in detectionRun: $_debugMessage');
                      },
                    );
                    webViewController?.addJavaScriptHandler(
                      handlerName: 'detectionResult',
                      callback: (args) {
                        try {
                          dynamic decodedData;

                          // Decode JSON if the input is a String
                          if (args[0] is String) {
                            decodedData = json.decode(args[0] ?? "[]");
                          } else {
                            decodedData = args[0];
                          }

                          // Ensure decodedData is a List and parse each item as ResultPersonalityModel
                          if (decodedData is List) {
                            List<ResultPersonalityModel> data = decodedData
                                .map((item) => ResultPersonalityModel.fromJson(item))
                                .toList();

                            // Flatten list if necessary (ensure data structure is compatible with expand)
                            List<ResultPersonalityModel> flatList = data.expand((x) => [x]).toList();

                            // for (var item in flatList) {
                            //   print(item.name);
                            //   context.read<PfBloc>().add(UpdateDataResultPf(item));
                            // }

                            context.read<PfBloc>().add(UpdateDataResultPf(flatList));
                            context.read<PfBloc>().add(FetchProduct());

                            setState(() {
                              _showAnalysisResults = true;
                            });
                          } else {
                            print('Decoded data is not a List');
                          }
                        } catch (e) {
                          print('Error parsing detection result: $e');
                        }

                        setState(() {
                          _isLoading = false;
                        });
                        print('Detection result received: ${args.isNotEmpty ? args[0] : 'No data'}');
                      },
                    );
                  },
                  onPermissionRequest: (controller, permissionRequest) async {
                    return PermissionResponse(
                      resources: permissionRequest.resources,
                      action: PermissionResponseAction.GRANT,
                    );
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print('Console message: ${consoleMessage.message}');
                  },
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (_showAnalysisResults)
                  PFAnalysisResultsWidget(pfState: context.read<PfBloc>().state),
              ],
            ),
          );
        }
    );
  }
}
