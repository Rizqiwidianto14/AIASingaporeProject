//
//  IntradayViewModel.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 17/12/20.
//

import Foundation

class Dynamic<T>: Decodable where T: Decodable {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    func bind(listener: @escaping Listener){
        self.listener = listener
        self.listener?(self.value)
    }
    init(_ value: T) {
        self.value = value
    }
    private enum CodingKeys: CodingKey {
        case value
    }
    
}



// MARK: - Stocks
struct IntradayViewModel: Decodable {
    let timeSeriesIntraday: [String: TimeSeriesIntraday]
    let metaData: IntraDayMeta
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metaData = try container.decode(IntraDayMeta.self, forKey: .metaData)
        timeSeriesIntraday = try container.decode([String: TimeSeriesIntraday].self, forKey: .timeSeriesIntraday)
    }

    enum CodingKeys: String, CodingKey {
        case timeSeriesIntraday = "Time Series (5min)"
        case metaData = "Meta Data"
    }
}


struct TimeSeriesIntraday: Decodable {
    let the1Open, the2High, the3Low, the4Close: Dynamic<String>
    let the5Volume: Dynamic<String>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        the1Open = Dynamic(try container.decode(String.self, forKey: .the1Open))
        the2High = Dynamic(try container.decode(String.self, forKey: .the2High))
        the3Low = Dynamic(try container.decode(String.self, forKey: .the3Low))
        the4Close = Dynamic(try container.decode(String.self, forKey: .the4Close))
        the5Volume = Dynamic(try container.decode(String.self, forKey: .the5Volume))
    }


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






























//struct IntradayViewModel {
//    private let stock : TimeSeriesIntraday
//}
//extension IntradayViewModel{
//    init(_ stock: TimeSeriesIntraday) {
//        self.stock = stock
//    }
//}
//
//extension IntradayViewModel{
//    var the1Open : String{
//        return self.stock.the1Open
//    }
//    var the2High : String{
//        return self.stock.the2High
//    }
//    var the3Low : String{
//        return self.stock.the3Low
//    }
//    var the4Close : String{
//        return self.stock.the4Close
//    }
//    var the5Volume : String{
//        return self.stock.the5Volume
//    }
//}
//
//struct IntradayListViewModel{
//    let stocks: [String: TimeSeriesIntraday]
//    
//    var numberOfSections: Int {
//        return 1
//    }
//    
//    func numberOfRowsInSection(_ section: Int) -> Int {
//        return self.stocks.count
//    }
    
//    func stockAtIndex(_ index: Int) -> TimeSeriesIntraday {
//        let stock = stocks[]
//        return TimeSeriesIntraday(stock)
//    }

    

    
//}
