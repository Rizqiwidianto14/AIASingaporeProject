//
//  Services.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 16/12/20.
//

import Foundation

class DailyServices{
    
    func getStockData(url: URL, completion: @escaping ([String: TimeSeriesDaily]?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let stockList = try? JSONDecoder().decode(DailyStock.self, from: data)
                if let stockList = stockList {
                    completion(stockList.timeSeriesDaily)
                }
                print(stockList?.timeSeriesDaily)
                
            }
        }.resume()
    }
}

class IntradayServices{
    func getStockData(url: URL, completion: @escaping ([String: TimeSeriesIntraday]?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let stockList = try? JSONDecoder().decode(IntradayStocks.self, from: data)
                if let stockList = stockList {
                    completion(stockList.timeSeriesIntraday)
                }
                
                //Narik Tanggal
                var myDictionary = stockList!.timeSeriesIntraday
                let arrayOfKeys: [String] = myDictionary.map{String($0.key)}
                // Narik Specific Value
                for element in arrayOfKeys{
                    print((stockList!.timeSeriesIntraday[element]!.the3Low))
                }

                
            }
        }.resume()
    }
}

