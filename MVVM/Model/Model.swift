//
//  Model.swift
//  MVVM
//
//  Created by Darshan on 08/03/22.
//

import Foundation
import UIKit

struct WatchList: Codable {
    let dayHigh, dayLow: Double
    let eps: Int
    let exch, exchType, fullName: String
    let high52Week: Int
    let lastTradePrice: Double
    let lastTradeTime: String
    let low52Week, month: Int
    let name: String
    let nseBseCode: Int
    let pClose: Double
    let quarter, scripCode: Int
    let shortName: String
    let volume, year: Int
    var watchListNumber:Int?
    
    enum CodingKeys: String, CodingKey {
        case dayHigh = "DayHigh"
        case dayLow = "DayLow"
        case eps = "EPS"
        case exch = "Exch"
        case exchType = "ExchType"
        case fullName = "FullName"
        case high52Week = "High52Week"
        case lastTradePrice = "LastTradePrice"
        case lastTradeTime = "LastTradeTime"
        case low52Week = "Low52Week"
        case month = "Month"
        case name = "Name"
        case nseBseCode = "NseBseCode"
        case pClose = "PClose"
        case quarter = "Quarter"
        case scripCode = "ScripCode"
        case shortName = "ShortName"
        case volume = "Volume"
        case year = "Year"
        case watchListNumber = "watchListNumber"
    }
}

