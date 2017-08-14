//: Playground - noun: a place where people can play

import UIKit
import Foundation

let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
let mydate = formatter.date(from: "19/08/2019 23:50:09")

let calendar = Calendar.current
let h = calendar.component(.hour, from: mydate!)

print(calendar.component(.day, from: mydate!))


