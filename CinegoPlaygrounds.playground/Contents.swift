//: Playground - noun: a place where people can play

import UIKit
import Foundation


struct MovieSession {
    let id: Int
    let startDate: String
}

var movieSessions: [MovieSession] = [
    MovieSession(id: 1, startDate: "12-09-2018 23:30:00"),
    MovieSession(id: 2, startDate: "12-09-2019 23:40:00"),
    MovieSession(id: 5, startDate: "12-10-2017 23:30:00"),
    MovieSession(id: 6, startDate: "19-09-2015 23:30:00"),
    MovieSession(id: 7, startDate: "22-09-2010 23:30:00"),
    MovieSession(id: 3, startDate: "12-09-2016 23:50:00"),
    MovieSession(id: 4, startDate: "12-09-2017 23:59:00"),
]

let formatter = DateFormatter()
formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"

let sorted = movieSessions.sorted(by: { sessionA, sessionB -> Bool in
    let dateA = formatter.date(from: sessionA.startDate)!
    let dateB = formatter.date(from: sessionB.startDate)!
    
    return dateA < dateB
})

sorted