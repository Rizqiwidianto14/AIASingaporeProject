//
//  Services.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 16/12/20.
//

import Foundation

class WebServices{
    
    func getStockData(url: URL, completion: @escaping ([String: TimeSeriesDaily]?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let stockList = try? JSONDecoder().decode(Stock.self, from: data)
                if let stockList = stockList {
                    completion(stockList.timeSeriesDaily)
                }
                print(stockList?.timeSeriesDaily)
                
            }
        }.resume()
    }
}

