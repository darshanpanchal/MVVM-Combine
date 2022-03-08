//
//  WatchListTableViewCell.swift
//  Neosoft_Assignment
//
//  Created by Darshan on 16/02/22.
//

import UIKit
import Combine


class WatchListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblFullName:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblExch:UILabel!
    @IBOutlet weak var lblExchType:UILabel!
    @IBOutlet weak var lblDayLow:UILabel!
    
    let action = PassthroughSubject<Int,Never>()
    @IBOutlet weak var containerView:UIView!
    
    
    var watchlistModel:WatchList?{
        didSet{
            //setup user model data
            self.setupUserModelData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.separatorInset = UIEdgeInsets.zero
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 8.0
        self.containerView.layer.borderWidth = 0.8
        self.containerView.layer.borderColor = UIColor.label.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func setupUserModelData(){
        self.lblName.text = "\(watchlistModel?.name ?? "")"
        self.lblFullName.text = "\(watchlistModel?.fullName ?? "")"
        self.lblPrice.text = "₹ \(watchlistModel?.lastTradePrice ?? 0.0)"
        self.lblExch.text = "\(watchlistModel?.exch ?? "")" == "N" ? "NSE":"BSE"
        self.lblExchType.text = "\(watchlistModel?.exchType ?? "")" == "C" ? "Cash" : "Future"
        self.lblDayLow.text = "₹ \(watchlistModel?.dayLow ?? 0.0)"
    }
    //Selector Methods
    @IBAction func buttonDeleteSelector(sender:UIButton){
        self.action.send(self.tag)
    }
}
