//
//  TicketCalculationService.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit

protocol ITicketCalculationService: class {
    func getPricePerTicket() -> Promise<Double>
    func getGSTRate() -> Promise<Double>
    func getTransactionFee() -> Promise<Double>
    func calculate(totalPriceOfTickets numTickets: Int) -> Promise<Double>
    func calculate(subtotalPriceOfTickets numTickets: Int) -> Promise<Double>
    func calculate(totalGSTOfTickets numTickets: Int) -> Promise<Double>
}

class TicketCalculationService: ITicketCalculationService {
    
    let PRICE_PER_TICKET: Double
    let GST_RATE: Double
    let TRANSACTION_FEE: Double
    
    init(pricePerTicket: Double = 20.00, gstRate: Double = 0.1, transactionFee: Double = 0.0){
        guard pricePerTicket > 0.0 else {
            fatalError("Price per ticket should never be less than or equal to 0")
        }
        
        guard gstRate >= 0.0 else {
            fatalError("GST rate should never be negative")
        }
        
        guard transactionFee >= 0.0 else {
            fatalError("Transaction fee should never be negative")
        }
        
        self.PRICE_PER_TICKET = pricePerTicket
        self.GST_RATE = gstRate
        self.TRANSACTION_FEE = transactionFee
    }
    
    func getPricePerTicket() -> Promise<Double> {
        return Promise { fulfill, reject in
            fulfill(PRICE_PER_TICKET)
        }
    }
    
    func getGSTRate() -> Promise<Double> {
        return Promise { fulfill, reject in
            fulfill(GST_RATE)
        }
    }
    
    func getTransactionFee() -> Promise<Double> {
        return Promise { fulfill, reject in
            fulfill(TRANSACTION_FEE)
        }
    }
    
    func calculate(totalPriceOfTickets numTickets: Int) -> Promise<Double> {
        return getPricePerTicket().then { pricePerTicket in
            return Promise { fulfill, reject in
                let totalPrice = Double(numTickets) * pricePerTicket
                fulfill(totalPrice)
            }
        }
    }
    
    func calculate(subtotalPriceOfTickets numTickets: Int) -> Promise<Double> {
        return when(fulfilled:
            calculate(totalPriceOfTickets: numTickets),
            calculate(totalGSTOfTickets: numTickets),
            getTransactionFee()
        ).then(execute: { (totalPrice, gstPrice, transactionFee) in
            return Promise { fulfill, reject in
                let subtotalPrice = totalPrice - gstPrice - transactionFee
                fulfill(subtotalPrice)
            }
        })
    }
    
    func calculate(totalGSTOfTickets numTickets: Int) -> Promise<Double> {
        return when(fulfilled: calculate(totalPriceOfTickets: numTickets), getGSTRate())
        .then { (totalPrice, gstRate) in
            return Promise { fulfill, reject in
                let gstPrice = totalPrice * (1.0 - totalPrice)
                fulfill(gstPrice)
            }
        }
    }
    
    
    
}
