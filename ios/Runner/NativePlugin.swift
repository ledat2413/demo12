//
//  NativePlugin.swift
//  Runner
//
//  Created by Peterrr on 10/01/2022.
//

import Foundation

public class NativeViewPlugin {
 class func register(with registrar: FlutterPluginRegistrar) {
   let viewFactory = FLNativeViewFactory(messenger: registrar.messenger())
   registrar.register(viewFactory, withId: "native-ios-view")
 }
}
