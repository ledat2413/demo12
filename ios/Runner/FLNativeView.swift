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
    private var _view: UIView
    private var messenger: FlutterBinaryMessenger
    
    private var textUpdate: String = ""
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _view = UIView()
        self.messenger = messenger
        self.textUpdate = args as! String
        super.init()
        
        // iOS views can be created here
        self.createNativeView(view: _view)
        self.createChannel(binaryMessenger: messenger)
        
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createChannel(binaryMessenger messenger: FlutterBinaryMessenger){
        let channel = FlutterMethodChannel(name: "methodDat", binaryMessenger: messenger )
        
        //        channel.setMethodCallHandler({
        //            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        //            guard call.method == "getText" else {
        //                result(FlutterMethodNotImplemented)
        //                return
        //            }
        //            DispatchQueue.main.async {
        //                self.textUpdate = call.arguments as! String
        //            }
        //
        //        })
    }
    
    
    
    func createNativeView(view _view: UIView){
        let flView = FLView()
        _view.addSubview(flView)
        //        _view.backgroundColor = UIColor.white
        //        let nativeLabel = UILabel()
        //        nativeLabel.text = textUpdate
        //        nativeLabel.textColor = UIColor.red
        //        nativeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //        nativeLabel.textAlignment = .center
        //        nativeLabel.font = UIFont(name: "", size: 20)
        //        nativeLabel.frame = CGRect(x: 120, y:  200, width: 180, height: 48.0)
        //
        //        let nativeButton = UIButton()
        //
        //        nativeButton.backgroundColor = .gray
        //        nativeButton.setTitle("Send text to Flutter", for: .normal)
        //        nativeButton.titleLabel?.textColor = .white
        //        nativeButton.titleLabel?.textAlignment = .center
        //        nativeButton.frame = CGRect(x: 100, y: 50,width:200, height: 30)
        //        nativeButton.addTarget(self, action: #selector(getText), for: .touchUpInside)
        //
        //        _view.addSubview(nativeButton)
        //        _view.addSubview(nativeLabel)
    }
    
    @objc func getText(){
        let channel = FlutterMethodChannel(name: "methodDat", binaryMessenger: messenger)
        channel.invokeMethod("sendFromNative", arguments: "Text update from native")
    }
}
