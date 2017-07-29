//
//  ITicketRepository.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol ITicketRepository {
    func getTickets(fromSession movieSession: MovieSession ) -> [Ticket]
}
