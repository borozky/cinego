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
    
    // TODO: Put these in a ViewModel
    var cinema: Cinema!
    var selectedSeats: [Seat]!
    var numTickets: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cinema.seatingArrangement.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cinema.seatingArrangement[section].count
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let seat = cinema.seatingArrangement[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
        let foundSeat = selectedSeats.filter { $0.id == seat.id }
        
        cell.seat = foundSeat.count > 0 ? foundSeat.first : seat
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0).cgColor
        
        switch cell.seat.status {
        case .AVAILABLE:
            cell.layer.backgroundColor = UIColor.white.cgColor
        case .SELECTED:
            cell.layer.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5).cgColor
        default:
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
    
    // cell are rendered downwards per column, scrolls horizontally
    // seat spacing is normally 4pt left and right
    // but sections are spaced out to one another by 24pt (4pt left, 20pt right)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let screenHeight = collectionView.frame.height
        let seatSectionHeight = (Seat.defaultSize + 8) * cinema.rows.count - 8
        let offset = 0.0
        let topSpacing = Double(screenHeight / 2) - Double(seatSectionHeight) + offset
        
        if collectionView.numberOfItems(inSection: section) > 0 {
            
            // for sections [3,4,4,5,4] the firstColumnsAfterLastColumns will be cols 4,8,12,17
            // columns 1 and 19 are not included because they are first and last of all columns
            /*
                [-][-][-]    [-][-][-][-]    [-][-][-][-]    [-][-][-][-][-]    [-][-][-]
                [-][-][-]    [-][-][-][-]    [-][-][-][-]    [-][-][-][-][-]    [-][-][-]
                [-][-][-] 20 [-][-][-][-] 20 [-][-][-][-] 20 [-][-][-][-][-] 20 [-][-][-]
                [-][-][-]    [-][-][-][-]    [-][-][-][-]    [-][-][-][-][-]    [-][-][-]
                [-][-][-]    [-][-][-][-]    [-][-][-][-]    [-][-][-][-][-]    [-][-][-]
                              ^               ^               ^                  ^
             
             tableview's section 0 is invisible.
            */
            var firstColumnsAfterLastColumns: [Int] = []
            for i in 0..<cinema.seatMatrix.count {
                let firstColumnAfterLastColumns = cinema.seatMatrix[0...i].reduce(0){ $0 + $1 }
                firstColumnsAfterLastColumns.append(firstColumnAfterLastColumns)
            }
            
            if firstColumnsAfterLastColumns.contains(section) {
                return UIEdgeInsets(top: CGFloat(topSpacing), left: 20, bottom: 0, right: 4)
            }
        }
        
        return UIEdgeInsets(top: CGFloat(topSpacing), left: 4, bottom: 0, right: 4)
    }
}
