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
    
    @IBOutlet weak var searchSymbol: BindingTextField!{
        didSet{
            searchSymbol.bind{ self.intradayListVM.symbol = $0 }
        }
    }
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func searchButtonPressed(){
        print(self.intradayListVM.symbol)
        setUp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
        cell.symbolLabel.text = self.intradayListVM.symbol
        return cell
    }
    
}

extension IntradayVC{
    func setUp() {
        let symbol = self.intradayListVM.symbol
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=5min&apikey=JD109RV7JNDNU0Z0")!
        
        let intradayResource = Resource<IntradayViewModel>(url: url) { data in
            
            let intradayVM = try? JSONDecoder().decode(IntradayViewModel.self, from: data)
            return intradayVM
        }
        
        Webservice().load(resource: intradayResource) { [weak self] result in
            
            if let intradayVM = result {
                let dict = intradayVM.timeSeriesIntraday
                let myKeys: [String] = dict.map{String($0.key)}
                let dateFormatter = DateFormatter()
                
                var arrayOfDate = [String]()
                for element in myKeys{
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatter.date(from: element)
                    let newDate = dateFormatter.string(from: date!)
                    arrayOfDate.append(newDate)
                }
                
                
                let sortedArray = arrayOfDate.sorted{dateFormatter.date(from: $0) ?? Date() > dateFormatter.date(from: $1) ?? Date()}
                print(sortedArray)
                for element in sortedArray{
                    self?.intradayListVM.open.append(intradayVM.timeSeriesIntraday[element]?.the1Open.value ?? "nil")
                    self?.intradayListVM.high.append(intradayVM.timeSeriesIntraday[element]?.the2High.value ?? "nil")
                    self?.intradayListVM.low.append(intradayVM.timeSeriesIntraday[element]?.the3Low.value ?? "nil")
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatter.date(from: element)
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                    let newDate = dateFormatter.string(from: date!)
                    self?.arrayOfKeys.append(newDate)
                }

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }
            
        }
    }
}

