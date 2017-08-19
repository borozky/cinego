//
//  SeatsCollectionVC.swift
//  cinego
//
//  Created by Victor Orosco on 19/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol SeatCollectionVCDelegate: class {
    func didSelectSeats(_ seats: [Seat])
}

class SeatsCollectionVC: UICollectionViewController {
    
    weak var delegate: SeatCollectionVCDelegate?
    
    let sections = [4,6,6,4]
    let rowNumbers: [Character] = ["A", "B", "C", "D"]
    var seatMatrix: [[Seat]] = [[]]
    var selectedSeats: [Seat] = []
    var numTickets = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSeatMatrix()
    }
    
    
    func setupSeatMatrix(){
        var currentID = 1
        var startingColumnNumber = 1
        for numOfColumnsInSection in sections {
            for colNumber in startingColumnNumber..<(startingColumnNumber + numOfColumnsInSection) {
                var column: [Seat] = []
                for rowNumber in rowNumbers {
                    column.append(Seat(id: currentID, rowNumber: rowNumber, colNumber: colNumber, status: .AVAILABLE))
                    currentID += 1
                }
                seatMatrix.append(column)
            }
            startingColumnNumber += numOfColumnsInSection
        }
    }
    
    

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seatMatrix.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seatMatrix[section].count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let seat = seatMatrix[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
        let foundSeat = selectedSeats.filter { $0.id == seat.id }
        
        cell.seat = foundSeat.count > 0 ? foundSeat.first : seat
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0).cgColor
        
        
        if cell.seat.status == .SELECTED {
            cell.layer.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5).cgColor
        } else if cell.seat.status == .AVAILABLE {
            cell.layer.backgroundColor = UIColor.white.cgColor
        } else {
            cell.layer.backgroundColor = UIColor.darkGray.cgColor
        }
        
        let label = cell.viewWithTag(1) as! UILabel
        label.text = "\(String(cell.seat.rowNumber))\(String(cell.seat.colNumber))"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SeatCollectionViewCell
        let label = cell.viewWithTag(1) as! UILabel
        
        if cell.seat.status == .RESERVED {
            return
        }
        
        if cell.seat.status == .AVAILABLE {
            
            if selectedSeats.count >= numTickets {
                return
            }
            
            cell.seat.status = .SELECTED
            selectedSeats.append(cell.seat)
            cell.layer.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5).cgColor
            let label = cell.viewWithTag(1) as! UILabel
            label.textColor = UIColor.white
            return
        }
        
        if cell.seat.status == .SELECTED {
            
            // remove a seat from selectedSeats[], 
            // that is when seatIDs match, remove that item
            self.selectedSeats = self.selectedSeats.filter {
                return $0.id != cell.seat.id
            }
            
            cell.seat.status = .AVAILABLE
            cell.layer.backgroundColor = UIColor.white.cgColor
            label.textColor = UIColor.darkGray
            
            return
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.didSelectSeats(selectedSeats)
    }
}


extension SeatsCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let screenHeight = collectionView.frame.height
        let seatSectionHeight = (Seat.defaultSize + 8) * rowNumbers.count - 8
        let offset = 0.0
        let topSpacing = Double(screenHeight / 2) - Double(seatSectionHeight) + offset
        
        if collectionView.numberOfItems(inSection: section) > 0 {
            var lastColumns: [Int] = []
            for i in 0..<sections.count {
                let lastColumn = sections[0...i].reduce(0){ $0 + $1 }
                lastColumns.append(lastColumn)
            }
            
            if lastColumns.contains(section) {
                return UIEdgeInsets(top: CGFloat(topSpacing), left: 4, bottom: 0, right: 20)
            }
        }
        
        return UIEdgeInsets(top: CGFloat(topSpacing), left: 4, bottom: 0, right: 4)
    }
}
