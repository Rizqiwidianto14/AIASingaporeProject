//
//  ViewController.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 16/12/20.
//

import UIKit

class IntradayVC: UIViewController {
//    private var intraDayVM: IntradayListViewModel!
    var open = [String]()
    var high = [String]()
    var low = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //
        setUp()
    }
    
    private func setUp(){
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=JD109RV7JNDNU0Z0")!
        
        IntradayServices().getStockData(url: url) { stocks in
            if let stocks = stocks{

                let arrayOfKeys = stocks.keys
                for element in arrayOfKeys{
                    self.open.append(stocks[element]?.the1Open.value ?? "nil")
                    self.high.append(stocks[element]?.the2High.value ?? "nil")
                    self.low.append(stocks[element]?.the3Low.value ?? "nil")
                    
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }


            }

        }
    }
    
    
    
    
    
    
}

extension IntradayVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(open.count)
        return open.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "intradayCell", for: indexPath) as? IntradayCell else {
            fatalError("IntradayTableView not found")
        }
        
        cell.dateLabel.text = open[indexPath.row]
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


