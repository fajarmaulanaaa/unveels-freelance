import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';  // Import permission_handler package

import '../../../../shared/configs/route_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _requestCameraPermission();  // Request permission when the app starts
  }

  // Method to request camera permission
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isDenied) {
      // Handle permission denied scenario
      print("Camera permission denied");
    } else if (status.isPermanentlyDenied) {
      // Handle permanently denied scenario (show settings prompt)
      print("Camera permission permanently denied");
      openAppSettings();
    } else if (status.isGranted) {
      // Permission granted
      print("Camera permission granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.horizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              width: context.width,
              text: 'Find the Look',
              onTap: _onFindTheLook,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Skin Analysis',
              onTap: _onSaLive,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Skin Tone Finder',
              onTap: _onStfLive,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Personality Finder',
              onTap: _onPfLive,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Shop the Look',
              onTap: _onStlLive,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Face Analyzer',
              onTap: _onFaWeb,
            ),
          ],
        ),
      ),
    );
  }

  void _onFindTheLook() {
    context.goNamed(
      AppRoute.ftlHome.name,
    );
  }

  void _onSaLive() {
    context.goNamed(
      AppRoute.saWebview.name,
    );
  }

  void _onStfLive() {
    context.goNamed(
      AppRoute.stfWebview.name,
    );
  }

  void _onPfLive() {
    context.goNamed(
      AppRoute.pfWebView.name,
    );
  }

  void _onStlLive() {
    context.goNamed(
      AppRoute.stlLive.name,
    );
  }

  void _onFaWeb() {
    context.goNamed(
      AppRoute.faWebView.name,
    );
  }
}