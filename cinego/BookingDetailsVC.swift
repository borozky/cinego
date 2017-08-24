//
//  BookingDetailsVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol BookingDetailsVCDelegate: class {
    func didBook(_ cartItem: CartItem)
}

class BookingDetailsVC: UIViewController {
    
    
    // TODO: These data shoul be in a ViewModel
    var cartRepository: ICartRepository!
    var cartItem: CartItem?
    var movie: Movie!
    var movieSession: MovieSession!
    var selectedSeats: [Seat] = []
    var numTickets: Int {
        return selectedSeats.count
    }
    var cinema: Cinema {
        return movieSession.cinema
    }
    var fromCart: Bool {
       return cartItem != nil
    }
    
    weak var delegate: BookingDetailsVCDelegate?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleasedYearLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var bookToSessionButton: UIButton!
    @IBOutlet weak var cinemaLocationLabel: UILabel!
    @IBOutlet weak var cinemaAddressLabel: UILabel!
    @IBOutlet weak var movieSessionStartLabel: UILabel!
    
    @IBOutlet weak var bookingPricePreviewLabel: UILabel!
    @IBOutlet weak var bookingPriceCalculationLabel: UILabel!
    @IBOutlet weak var seatingArrangementCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seatingArrangementCollectionView.dataSource = self
        seatingArrangementCollectionView.delegate = self
        
        
        // setup data
        if let cartItem = cartItem {
            movie = cartItem.movieSession.movie
            movieSession = cartItem.movieSession
            selectedSeats = cartItem.seats
        }
        
        // setup movie
        movieTitleLabel.text = movie?.title
        movieReleasedYearLabel.text = "Released: \(movie.releaseDate )"
        movieBannerImageView.image = UIImage(imageLiteralResourceName: (movie?.images[0])!)
        
        
        // setup movie session details
        cinemaLocationLabel.text = movieSession.cinema.name
        cinemaAddressLabel.text = movieSession.cinema.address
        movieSessionStartLabel.text = humaniseTime(movieSession.startTime)
        
        
        // setup book button
        if cartItem != nil {
            bookToSessionButton.titleLabel?.text = "Update"
        }
        if numTickets > 0 {
            bookToSessionButton.isEnabled = true
            bookToSessionButton.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0)   // strong purple
        } else {
            bookToSessionButton.isEnabled = false
            bookToSessionButton.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5)   // light purple
        }
        
        bookToSessionButton.setTitle(cartItem != nil ? "Update" : "Book", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bookToSessionButton.setTitle(cartItem != nil ? "Update" : "Book", for: .normal)
    }
    
    // Date() -> "Mon 28 Aug 09:30 am
    private func humaniseTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
    }
    
}

extension BookingDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movieSession.cinema.seatingArrangement.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSession.cinema.seatingArrangement[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let seat = cinema.seatingArrangement[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
        let foundSeat = selectedSeats.filter { $0.id == seat.id }
        
        cell.seat = foundSeat.count > 0 ? foundSeat.first : seat
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0).cgColor
        cell.layer.cornerRadius = cell.frame.size.width / 2
        cell.clipsToBounds = true
        
        switch cell.seat.status {
        case .AVAILABLE: cell.layer.backgroundColor = UIColor.white.cgColor
        case .SELECTED: cell.layer.backgroundColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:0.5).cgColor
        default: cell.layer.backgroundColor = UIColor.darkGray.cgColor
        }
        
        let label = cell.viewWithTag(1) as! UILabel
        label.text = "\(String(cell.seat.rowNumber))\(String(cell.seat.colNumber))"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
    
}

extension BookingDetailsVC: UICollectionViewDelegateFlowLayout {
    // cell are rendered downwards per column, scrolls horizontally
    // seat spacing is normally 4pt left and right
    // but sections are spaced out to one another by 24pt (4pt left, 20pt right)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let topSpacing = 10.0
        
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



// book, update or buy more tickets
extension BookingDetailsVC {

    func book(toSession session: MovieSession) {
        let cartItem = CartItem(movieSession: movieSession, numTickets: numTickets, seats: selectedSeats)
        cartRepository.addToCart(cartItem: cartItem)
        delegate?.didBook(cartItem)
        goBack()
    }
    
    func updateBooking(){
        cartItem!.seats = selectedSeats
        cartItem!.numTickets = numTickets
        guard cartRepository.updateCart(cartItem!) != nil else {
            fatalError("Failed to add to cart")
        }
        goBack()
    }
    
    func goBack(){
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
