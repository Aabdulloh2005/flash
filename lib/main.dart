import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlashlightControl(),
    );
  }
}

class FlashlightControl extends StatefulWidget {
  const FlashlightControl({super.key});

  @override
  State<FlashlightControl> createState() => _FlashlightControlState();
}

class _FlashlightControlState extends State<FlashlightControl> {
  static const platform = MethodChannel('com.example.flashlight/flashlight');

  bool isFlashOn = false;

  Future<void> toggleFlashlight() async {
    try {
      final bool result = await platform.invokeMethod('toggleFlashlight');
      setState(() {
        isFlashOn = result;
      });
    } on PlatformException catch (e) {
      print("Failed to toggle flashlight: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashlight Control'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text(isFlashOn ? "Turn on" : "Turn off"),
          value: isFlashOn,
          onChanged: (value) {
            toggleFlashlight();
          },
        ),
      ),
    );
  }
}
