import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../cubit/product_cart/product_cart_cubit.dart';
import '../widgets/stl_makeup_widget.dart';
import '../widgets/stl_products_list_widget.dart';

class STLWebviewPage extends StatelessWidget {
  const STLWebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCartCubit(),
      child: const _STLWebviewBody(),
    );
  }
}

class _STLWebviewBody extends StatefulWidget {
  const _STLWebviewBody();

  @override
  State<_STLWebviewBody> createState() => __STLWebviewBodyState();
}

class __STLWebviewBodyState extends State<_STLWebviewBody> {
  InAppWebViewController? webViewController;
  late LiveStep step;
  bool _isHideTryThisLookButton = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    // Default step
    step = LiveStep.scannedFace;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STL Webview Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                  print('Data received in detectionRun: ${args.isNotEmpty ? args[0] : 'No data'}');
                },
              );
              webViewController?.addJavaScriptHandler(
                handlerName: 'detectionResult',
                callback: (args) {
                  // try {
                  //   dynamic decodedData;
                  //   if (args[0] is String) {
                  //     decodedData = json.decode(args[0] ?? "[]");
                  //   } else {
                  //     decodedData = args[0];
                  //   }
                  //   if (decodedData is List) {
                  //     List<ResultPersonalityModel> data = decodedData
                  //         .map((item) => ResultPersonalityModel.fromJson(item))
                  //         .toList();
                  //     context.read<PfBloc>().add(UpdateDataResultPf(data));
                  //     context.read<PfBloc>().add(FetchProduct());
                  //   }
                  // } catch (e) {
                  //   print('Error parsing detection result: $e');
                  // }
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
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (step) {
      case LiveStep.photoSettings:
        return const SizedBox.shrink();
      case LiveStep.scanningFace:
        return const SizedBox.shrink();
      case LiveStep.scannedFace:
        if (_isHideTryThisLookButton) {
          return const BottomCopyrightWidget(child: SizedBox.shrink());
        }
        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'TRY THIS LOOK',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onProductsList,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return BottomCopyrightWidget(
          child: STLMakeupWidget(
            onProductsList: _onProductsList,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _onProductsList() async {
    setState(() {
      _isHideTryThisLookButton = true;
    });

    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                STLProductsListWidget(
                  onAddToCart: onAddToCart,
                ),
              ],
            ),
          ),
        );
      },
    );

    final productCartState = BlocProvider.of<ProductCartCubit>(context).state;
    if (productCartState is ProductCartLoaded && productCartState.products.isNotEmpty) {
      setState(() {
        step = LiveStep.makeup;
      });
    } else {
      setState(() {
        _isHideTryThisLookButton = false;
      });
    }
  }

  void onAddToCart() {
    BlocProvider.of<ProductCartCubit>(context).addProduct();
  }
}
