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
                self?.intradayListVM.high.append(intradayVM.timeSeriesIntraday[element]?.the2High.value ?? "nil")
                self?.intradayListVM.low.append(intradayVM.timeSeriesIntraday[element]?.the3Low.value ?? "nil")
            }

            
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
        
        cell.dateLabel.text = arrayOfKeys[indexPath.row]
        cell.openValue.text = intradayListVM.open[indexPath.row]
        cell.highValue.text = intradayListVM.high[indexPath.row]
        cell.lowValue.text = intradayListVM.low[indexPath.row]
        return cell
    }
    
}







//            for element in self!.arrayOfKeys{
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "YYYY-MM-DD hh:mm:ss +zzzz"
//                var dateObj = dateFormatter.date(from: element)
//                print(dateObj!)
////                dateFormatter.dateFormat = "MM-dd-yyyy"
////                let date = dateFormatter.string(from: dateObj!)
////                self?.intradayListVM.date.append(date)
//
//            }
