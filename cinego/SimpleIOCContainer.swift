//
//  IOCContainer.swift
//  cinego
//
//  Created by Victor Orosco on 18/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

// http://www.swiftexample.info/snippet/simpledicontainerswift_yoichitgy_swift
class SimpleIOCContainer {
    
    static let instance = SimpleIOCContainer()
    private init(){}
    
    var factories = [String: Any]()
    
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(reflecting: type)
        factories[key] = factory as Any
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(reflecting: type)
        guard let factory = factories[key] as? () -> T else {
            return nil
        }
        return factory()
    }
}
