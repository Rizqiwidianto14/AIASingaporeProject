//
//  IntradayViewModel.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 17/12/20.
//

import Foundation

struct IntradayViewModel {
    private let stock : TimeSeriesIntraday
}
extension IntradayViewModel{
    init(_ stock: TimeSeriesIntraday) {
        self.stock = stock
    }
}

extension IntradayViewModel{
    var the1Open : String{
        return self.stock.the1Open
    }
    var the2High : String{
        return self.stock.the2High
    }
    var the3Low : String{
        return self.stock.the3Low
    }
    var the4Close : String{
        return self.stock.the4Close
    }
    var the5Volume : String{
        return self.stock.the5Volume
    }
}

struct IntradayListViewModel{
    let stocks: [String: TimeSeriesIntraday]
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.stocks.count
    }
    
//    func stockAtIndex(_ index: Int) -> TimeSeriesIntraday {
//        let stock = stocks[]
//        return TimeSeriesIntraday(stock)
//    }

    

    
}
