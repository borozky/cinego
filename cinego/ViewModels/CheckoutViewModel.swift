//
//  CheckoutViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol CheckoutViewModelDelegate: class {
    
}

class CheckoutViewModel {
    
    var delegate: CheckoutViewModelDelegate
    
    init(_ delegate: CheckoutViewModelDelegate){
        self.delegate = delegate
    }
}
