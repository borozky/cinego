//
//  IRepository.swift
//  cinego
//
//  Created by Josh MacDev on 30/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

struct RepositoryError: Error {
    var message: String
    init(_ message: String){
        self.message = message
    }
    var localizedDescription: String {
        return message
    }
}

protocol ICreatable: class {
    associatedtype T
    func create() -> T
}

protocol IFindableById: class {
    associatedtype T
    func find(byId: String) -> T?
}

protocol IFindableAll: class {
    associatedtype T
    func findAll() -> [T]
}

protocol IDestructiveTransaction: class {
    associatedtype T
    func insert(_ entity: T) throws -> T?
    func update(_ entity: T) throws -> T?
    func delete(_ entity: T) throws -> Bool
}

protocol IRepository: ICreatable, IFindableAll, IDestructiveTransaction {}



