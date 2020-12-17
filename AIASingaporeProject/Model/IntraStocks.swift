//
//  IntraStocks.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 17/12/20.
//

import Foundation
// MARK: - Stocks
struct IntradayStocks: Decodable {
    let timeSeriesIntraday: [String: TimeSeriesIntraday]
    let metaData: IntraDayMeta

    enum CodingKeys: String, CodingKey {
        case timeSeriesIntraday = "Time Series (5min)"
        case metaData = "Meta Data"
    }
}


struct TimeSeriesIntraday: Decodable {
    let the1Open, the2High, the3Low, the4Close: String
    let the5Volume: String

    enum CodingKeys: String, CodingKey {
        case the1Open = "1. open"
        case the2High = "2. high"
        case the3Low = "3. low"
        case the4Close = "4. close"
        case the5Volume = "5. volume"
    }
}

struct IntraDayMeta: Decodable {
    let the1Information, the2Symbol, the3LastRefreshed, the4Interval: String
    let the5OutputSize, the6TimeZone: String

    enum CodingKeys: String, CodingKey {
        case the1Information = "1. Information"
        case the2Symbol = "2. Symbol"
        case the3LastRefreshed = "3. Last Refreshed"
        case the4Interval = "4. Interval"
        case the5OutputSize = "5. Output Size"
        case the6TimeZone = "6. Time Zone"
    }
}
