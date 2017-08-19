//: Playground - noun: a place where people can play

import UIKit
import Foundation

let sections = [1, 2, 4]
let columns = [0,  1, 2,  3, 4, 5, 6]

var lastColumns: [Int] = []
for i in 0..<sections.count {
    let lastColumn = sections[0...i].reduce(0){ $0 + $1 }
    lastColumns.append(lastColumn)
}

let items = columns.filter { lastColumns.contains($0) }
print(items)



