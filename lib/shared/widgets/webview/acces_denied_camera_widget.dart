import 'package:flutter/material.dart';

class AccessDeniedCameraWidget extends StatelessWidget {
  const AccessDeniedCameraWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return const Center(
      child:CircularProgressIndicator()
    );
  }
}
