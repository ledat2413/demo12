//
//  NativePlugin.swift
//  Runner
//
//  Created by Peterrr on 10/01/2022.
//

import Foundation


import Flutter
import UIKit

public class SwiftSamplePluginFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "DatChanel", binaryMessenger: registrar.messenger())
        let channel2 = FlutterMethodChannel(name: "dungChanel", binaryMessenger: registrar.messenger())
        
        let viewFactory = FLNativeViewFactory(channel: channel, messenger: registrar.messenger())
        let instance = SwiftSamplePluginFlutterPlugin()
        registrar.register(viewFactory, withId: "native-view")
        
        registrar.addMethodCallDelegate(instance, channel: channel2)
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let funcClass = FuncClass()
        switch call.method {
        case "getCountNumber":
            let number: Int = funcClass.countNumber(a: 3, b: 5)
            result(number)
            break
        default:
            result(nil)
        }
    }
}

