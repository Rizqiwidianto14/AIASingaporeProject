//
//  Services.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 16/12/20.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}
struct Resot<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
        
            if let data = data {
                DispatchQueue.main.async {
                     completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
    
}



//class IntradayServices{
//    var open = [String]()
//    var high = [String]()
//    var low = [String]()
//
//    func getStockData(url: URL, completion: @escaping ([String: TimeSeriesIntraday]?) -> ()){
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                completion(nil)
//            } else if let data = data {
//                let stockList = try? JSONDecoder().decode(IntradayViewModel.self, from: data)
//                if let stockList = stockList {
//                    completion(stockList.timeSeriesIntraday)
//                    print(type(of: stockList.timeSeriesIntraday))
//                }
////                print("stockList: \(stockList)")
//
////                Narik Tanggal
//                if let myDictionary = stockList?.timeSeriesIntraday{
//                    let arrayOfKeys: [String] = myDictionary.map{String($0.key)}
//                    // Narik Specific Value
//
//
//                    for element in arrayOfKeys{
//
//                        self.open.append(stockList?.timeSeriesIntraday[element]?.the1Open.value ?? "nil")
//                        self.high.append(stockList?.timeSeriesIntraday[element]?.the2High.value  ?? "nil")
//                        self.low.append(stockList?.timeSeriesIntraday[element]?.the3Low.value  ?? "nil")
//                    }
//
//                    print(self.open)
//                }
//
//
//
//
//            }
//        }.resume()
//    }
//}


class DailyServices{

    func getStockData(url: URL, completion: @escaping ([String: TimeSeriesDaily]?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let stockList = try? JSONDecoder().decode(DailyViewModel.self, from: data)
                if let stockList = stockList {
                    completion(stockList.timeSeriesDaily)
                }
                
                

            }
        }.resume()
    }
}
