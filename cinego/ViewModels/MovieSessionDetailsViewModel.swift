//
//  MovieSessionDetailsViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 24/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit

protocol MovieSessionDetailsViewModelDelegate: class{
    func seatsUpdated(_ selectedSeats: [Seat]) -> Void
    func reservedSeatsRetrieved(_ reservedSeats: [Seat]) -> Void
    func priceUpdated(_ unitPrice: Double, _ totalPrice: Double)
}

class MovieSessionDetailsViewModel {
    
    weak var delegate: MovieSessionDetailsViewModelDelegate?
    
    // ViewModel data
    // Properties are watched an upon data changes delegates are automatically called
    var movieSession: MovieSession!
    var selectedSeats: [Seat] = [] {
        didSet { delegate?.seatsUpdated(self.selectedSeats) }
    }
    var reservedSeats: [Seat] = [] {
        didSet { delegate?.reservedSeatsRetrieved(self.reservedSeats) }
    }
    
    var ticketCalculationService: ITicketCalculationService
    init(ticketCalculationService: ITicketCalculationService){
        self.ticketCalculationService = ticketCalculationService
    }
    
    // add new seat if doesn't exists, or remove existing ones
    func toggleSeat(_ seat: Seat){
        self.selectedSeats = self.selectedSeats.filter { $0.id != seat.id }
    }
    
    func updateSeats(_ seats: [Seat]){
        self.selectedSeats = seats
    }
    
    func fetchReservedSeats() {
        reservedSeats = []
    }
    
    func calculateTotalPrice(){
        when(fulfilled: ticketCalculationService.getPricePerTicket(),
             ticketCalculationService.calculate(totalPriceOfTickets: selectedSeats.count))
        .then { pricePerTicket, totalPrice in
            self.delegate?.priceUpdated(pricePerTicket, totalPrice)
        }.always {
            // nothing here
        }
    }
    
}
