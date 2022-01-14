import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngineParticular = FlutterEngine(name: "io.flutter")
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        NativeViewPlugin.register(with: registrar(forPlugin: "DatDemo") as! FlutterPluginRegistrar)
        
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    

}
