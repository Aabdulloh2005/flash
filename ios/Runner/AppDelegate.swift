import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
          let flashlightChannel = FlutterMethodChannel(name: "com.example.flashlight/flashlight",
                                                      binaryMessenger: controller.binaryMessenger)
          
          flashlightChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
              if call.method == "toggleFlashlight" {
                  self.isFlashOn = !self.isFlashOn
                  self.toggleFlashlight(status: self.isFlashOn)
                  result(self.isFlashOn)
              } else {
                  result(FlutterMethodNotImplemented)
              }
          }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

   private func toggleFlashlight(status: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            device.torchMode = status ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used")
        }
    }
}
