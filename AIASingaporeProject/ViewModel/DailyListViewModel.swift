//
//  DailyViewModel.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 18/12/20.
//

import Foundation

class DailyListViewModel{
    var openOne = [String]()
    var lowOne = [String]()
    var openTwo = [String]()
    var lowTwo = [String]()
    var date = [String]()
    
    var firstSymbol = "IBM"
    var secondSymbol = "AAPL"
}


// MARK: - Stocks
struct DailyViewModel: Decodable {
    let timeSeriesDaily: [String: TimeSeriesDaily]
    let metaData: DailyMetadata
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metaData = try container.decode(DailyMetadata.self, forKey: .metaData)
        timeSeriesDaily = try container.decode([String: TimeSeriesDaily].self, forKey: .timeSeriesDaily)
    }


    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}



struct TimeSeriesDaily: Decodable {
    let open, low: Dynamic<String>
    
  
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        open = Dynamic(try container.decode(String.self, forKey: .open))
        low = Dynamic(try container.decode(String.self, forKey: .low))

    }

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case low = "3. low"

    }
}

struct DailyMetadata: Decodable {
    let information, symbol, lastRefresh, outputSize: String
    let timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefresh = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timeZone = "5. Time Zone"
    }
}



