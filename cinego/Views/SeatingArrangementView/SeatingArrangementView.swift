//
//  SeatingArrangementView.swift
//  cinego
//
//  Created by Victor Orosco on 25/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit


protocol SeatingArrangementViewDelegate: class {
    func didUpdateSeats(_ selectedSeats: [Seat])
}

@IBDesignable
class SeatingArrangementView: UIView {

    weak var delegate: SeatingArrangementViewDelegate?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pricingSection: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceCalculationLabel: UILabel!
    @IBOutlet weak var seatingArrangementCollectionView: UICollectionView!
    
    var cinema: Cinema!
    var selectedSeats: [Seat] = [] {
        didSet(newValue){
            priceLabel.text = String(format: "$ %.02f", self.orderTotal)
            priceCalculationLabel.text = String(format: "$ %.02f per seat x %d", pricePerSeat, self.selectedSeats.count)
        }
    }
    var isSeatSelectable: Bool = true {
        didSet {
            titleLabel.text = "SELECTED SEATS"
        }
    }
    var reservedSeats: [Seat] = []
    var pricePerSeat: Double = 20.00
    var orderTotal: Double {
        return Double(selectedSeats.count) * pricePerSeat
    }

    // https://stackoverflow.com/documentation/ios/1362/custom-uiviews-from-xib-files#t=201708251212470621308

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        seatingArrangementCollectionView.register(SeatCollectionViewCell.self, forCellWithReuseIdentifier: "SeatCollectionViewCell")
        seatingArrangementCollectionView.dataSource = self
        seatingArrangementCollectionView.delegate = self
    }
    
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}

extension SeatingArrangementView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cinema.seatingArrangement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cinema.seatingArrangement[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let seat = cinema.seatingArrangement[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
        let foundSeat = selectedSeats.filter { $0.id == seat.id }
        
        // cell data and styling
        cell.seat = foundSeat.count > 0 ? foundSeat.first : seat
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0).cgColor
        cell.layer.cornerRadius = cell.frame.size.width / 2
        cell.clipsToBounds = true
        
        
        // color of seats depending on status
        switch cell.seat.status {
        case .AVAILABLE: cell.layer.backgroundColor = UIColor.white.cgColor
        case .SELECTED: cell.layer.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5).cgColor
        default: cell.layer.backgroundColor = UIColor.darkGray.cgColor
        }

        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SeatCollectionViewCell
        guard isSeatSelectable else {
            return
        }
        
        if cell.seat.status == .RESERVED {
            return
        }
        
        // select seats
        if cell.seat.status == .AVAILABLE {
            cell.seat.status = .SELECTED
            selectedSeats.append(cell.seat)
            cell.layer.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5).cgColor
            delegate?.didUpdateSeats(selectedSeats)
            return
        }
        
        
        // unselect seats
        if cell.seat.status == .SELECTED {
            self.selectedSeats = self.selectedSeats.filter { $0.id != cell.seat.id }
            cell.seat.status = .AVAILABLE
            cell.layer.backgroundColor = UIColor.white.cgColor
            delegate?.didUpdateSeats(selectedSeats)
            return
        }
    }
    
    private func updatePricing(){
        priceLabel.text = String(format: "$ %.02f", Double(selectedSeats.count) * pricePerSeat)
        priceCalculationLabel.text = String(format: "$ %.02f per seat x %d", pricePerSeat, selectedSeats.count)
    }
}


extension SeatingArrangementView: UICollectionViewDelegateFlowLayout {
    // cell are rendered downwards per column, scrolls horizontally
    // seat spacing is normally 4pt left and right
    // but sections are spaced out to one another by 24pt (4pt left, 20pt right)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let topSpacing = 10.0
        
        if collectionView.numberOfItems(inSection: section) > 0 {
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
