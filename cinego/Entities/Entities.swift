//
//  Entities.swift
//  cinego
//
//  Created by Victor Orosco on 23/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

enum PaymentTypes {
    case PAYPAL
    case CREDIT_CARD
}

enum UserTypes {
    case GUEST, NORMAL
}
struct UserEntity {
    let id: String?
    let username: String?
    let email: String?
    let fullname: String?
    var orders: [OrderEntity]
    var userType: UserTypes = .NORMAL
}


struct OrderEntity {
    let id: String?
    let gst: Double = 0.1
    let shipping: Double = 0.05
    let bookings: [BookingEntity]
    let address: String?
    let telephoneNumber: String?
    let paymentMethod: PaymentTypes
    let dateOfPurchase: String
}

struct BookingEntity {
    let number: String?
    let totalPrice: Double
    let unitPrice: Double
    let movieSession: MovieSessionEntity
    let numTickets: Int
    let tickets: [TicketEntity]
}

struct TicketEntity {
    let id: String
    let price: Double
    let seats: SeatEntity
}

struct CartItemEntity {
    let totalPrice: Double
    let unitPrice: Double
    let movieSession: MovieSessionEntity
    var numTickets: Int
    var seats: [SeatEntity]
}

enum ContentRatingTypes {
    case G, PG, MA15_PLUS, M, R18_PLUS, X18_PLUS, RC, NOT_RATED
}

struct MovieEntity {
    let id: String
    let title: String
    let releaseDate: String
    let duration: Int
    let details: String
    let audienceType: String
    let contentRating: ContentRatingTypes = .NOT_RATED
    let images: [String]
}

struct MovieSessionEntity {
    let id: String
    let startTime: String
    let cinema: CinemaEntity
    let movie: MovieEntity
}

struct CinemaEntity {
    let id: String
    let name: String
    let numSeats: Int
    let address: String
    let details: String
    let images: [String]
    let seatMatrix: [[SeatEntity]]
    let seats: [SeatEntity]
}

enum SeatingStatus {
    case AVAILABLE, SELECTED, RESERVED
}

struct SeatEntity {
    static let defaultSize = 32
    let id: Int
    let rowNumber: Character
    let colNumber: Int
    var status: SeatingStatus = .AVAILABLE
}








