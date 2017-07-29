//
//  ICinemaRepository.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol ICinemaRepository {
    func getAllCinemas() -> [Cinema]
    func getCinema(byId id: Int) -> Cinema?
    func getCinema(byName name: String) -> Cinema?
}
