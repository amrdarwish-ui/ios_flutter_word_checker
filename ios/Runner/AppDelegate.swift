import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
         let batteryChannel = FlutterMethodChannel(name: "word_check",
                                                   binaryMessenger: controller.binaryMessenger)
      batteryChannel.setMethodCallHandler({
           (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
           // This method is invoked on the UI thread.
           // Handle battery messages.
          if(call.method == "up"){
              if let arguments = call.arguments as? [String: Any],
                            let message = arguments["m"] as? String {
                             // Process the message as desired
                             
                  result(self.isCorrect(word: message))
                         } else {
                             result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                         }
          }
         })
      
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func isCorrect(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}

