//
//  ViewController.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 16/12/20.
//

import UIKit

class IntradayVC: UIViewController {

    var arrayOfKeys = [String]()
    var intradayListVM = IntradayListViewModel()
    var intradayVM: IntradayViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
       let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=JD109RV7JNDNU0Z0")!

       let intradayResource = Resource<IntradayViewModel>(url: url) { data in

           let intradayVM = try? JSONDecoder().decode(IntradayViewModel.self, from: data)
           return intradayVM
       }

       Webservice().load(resource: intradayResource) { [weak self] result in

           if let intradayVM = result {
            let dict = intradayVM.timeSeriesIntraday
            let myKeys: [String] = dict.map{String($0.key)}
            self?.arrayOfKeys = myKeys
            for element in self!.arrayOfKeys{
                self?.intradayListVM.open.append(intradayVM.timeSeriesIntraday[element]?.the1Open.value ?? "nil")
            }
            print(self?.intradayListVM.open ?? "nil")
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
            
        
            

           }

       }
   }
  
    
}

extension IntradayVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return arrayOfKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "intradayCell", for: indexPath) as? IntradayCell else {
            fatalError("IntradayTableView not found")
        }
        
        cell.dateLabel.text = intradayListVM.open[indexPath.row]
        return cell
    }
    
    
}


//        let stockResource = Resource<IntradayViewModel> (url: url) { data in
//            let intradayVM = try? JSONDecoder().decode(IntradayViewModel.self, from: data)
//            return intradayVM
//        }
//
//        Webservice().load(resource: stockResource) { [weak self] result in
//            if let intradayVM = result{
//
//                    self?.dismiss(animated: true, completion: nil)
//                let arrayOfKeys = intradayVM.timeSeriesIntraday.keys
//                    for element in arrayOfKeys{
//                        print(element)
//                    }
//
//
//            }
//
//        }










//    private func setUp(){
//        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=JD109RV7JNDNU0Z0")!
//
//        let intradayResource = Resource<IntradayViewModel>(url: url) { data in
//
//            let intradayVM = try? JSONDecoder().decode(IntradayViewModel.self, from: data)
//            return intradayVM
//        }
//
//        Webservice().load(resource: intradayResource) { [weak self] result in
//
//            if let intradayVM = result {
//                print(result?.timeSeriesIntraday.keys)
//            }
//
//        }
////        IntradayServices().getStockData(url: url) { stocks in
////            if let stocks = stocks{
////
////                let arrayOfKeys = stocks.keys
////                for element in arrayOfKeys{
////                    self.open.append(stocks[element]?.the1Open.value ?? "nil")
////                    self.high.append(stocks[element]?.the2High.value ?? "nil")
////                    self.low.append(stocks[element]?.the3Low.value ?? "nil")
////
////                }
////
////                DispatchQueue.main.async {
////                    self.tableView.reloadData()
////                }
////
////
////            }
////
////        }
//    }







