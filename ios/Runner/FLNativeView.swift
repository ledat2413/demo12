import Flutter
import UIKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        print("arguments \(String(describing: args))")
        if let argument = args as? Dictionary<String,Any>{
            return FLNativeView(frame: frame, viewIdentifier: viewId, arguments: argument["viewType"], binaryMessenger: messenger)
        }else {
            return FLNativeView(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
        }
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: FLView
    
    private var messenger: FlutterBinaryMessenger
    
    private var textUpdate: String = ""
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
        
    ) {
        _view = FLView()
        self.messenger = messenger
        self.textUpdate = args as! String
        super.init()
        self.createChannel(binaryMessenger: messenger)
        //        createNativeView(view: _view)
        
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createChannel(binaryMessenger messenger: FlutterBinaryMessenger){
        let channel = FlutterMethodChannel(name: "methodDat", binaryMessenger: messenger )
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "moveToNaviteScreen":
                self.presentView()
                break
                
            default:
                break
            }
        })
    }
    
    
    func presentView(){
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        
        let vc =  UIStoryboard.init(name: "UIStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true, completion: nil)
        
    }
    
//
//    func pushView(){
//        var windows = UIApplication.shared.keyWindow
//        windows = UIWindow(frame: UIScreen.main.bounds)
//        let nav1 = UINavigationController()
//        let mainView = DemoViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
//        nav1.viewControllers = [mainView]
//        windows?.rootViewController = nav1
//        windows?.makeKeyAndVisible()
//        let vc =  UIStoryboard.init(name: "UIStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
//        nav1.pushViewController(vc, animated: false)
//    }
}
