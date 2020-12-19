//
//  DailyVC.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 17/12/20.
//

import UIKit

class DailyVC: UIViewController {
    @IBOutlet weak var firstSymbol: UITextField!
    @IBOutlet weak var secondSymbol: UITextField!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dailyListVM = DailyListViewModel()
    var arrayOfKeysOne = [String]()
    var arrayOfKeysTwo = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

        // Do any additional setup after loading the view.
//        let firstURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=JD109RV7JNDNU0Z0")!

//        DailyServices().getStockData(url: firstURL) { result in
//
//            if let result = result{
//                print(result)
//            }
//        }
    }
    

}


extension DailyVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfKeysOne.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as? DailyCell else {
            fatalError("DailyTableView not found")
        }
        cell.dateLabel.text = arrayOfKeysOne[indexPath.row]
        cell.openValueOne.text = dailyListVM.openOne[indexPath.row]
        cell.openValueTwo.text = dailyListVM.openTwo[indexPath.row]
        cell.lowValueOne.text = dailyListVM.lowOne[indexPath.row]
        cell.lowValueTwo.text = dailyListVM.lowTwo[indexPath.row]
        return cell
        
    }
    
    
}

extension DailyVC{
    func setUp() {
        let firstURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=JD109RV7JNDNU0Z0")!
        let secondURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=AAPL&apikey=JD109RV7JNDNU0Z0")!
       let firstResource = Resource<DailyViewModel>(url: firstURL) { data in
        
           let dailyVM = try? JSONDecoder().decode(DailyViewModel.self, from: data)
           return dailyVM
       }
        let secondResource = Resource<DailyViewModel>(url: firstURL) { data in
         
            let dailyVM = try? JSONDecoder().decode(DailyViewModel.self, from: data)
            return dailyVM
        }

       Webservice().load(resource: firstResource) { [weak self] result in

           if let dailyVM = result {
            
            let dict = dailyVM.timeSeriesDaily
            let myKeys: [String] = dict.map{String($0.key)}
            self?.arrayOfKeysOne = myKeys
            print(self!.arrayOfKeysOne)
            for element in self!.arrayOfKeysOne{
                self?.dailyListVM.openOne.append(dailyVM.timeSeriesDaily[element]?.open.value ?? "nil")
                self?.dailyListVM.lowOne.append(dailyVM.timeSeriesDaily[element]?.low.value ?? "nil")
            }

            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }

           }

       }
        Webservice().load(resource: secondResource) { [weak self] result in

            if let dailyVM = result {
             
             let dict = dailyVM.timeSeriesDaily
             let myKeys: [String] = dict.map{String($0.key)}
             self?.arrayOfKeysTwo = myKeys
             for element in self!.arrayOfKeysTwo{
                 self?.dailyListVM.openTwo.append(dailyVM.timeSeriesDaily[element]?.open.value ?? "nil")
                self?.dailyListVM.lowTwo.append(dailyVM.timeSeriesDaily[element]?.low.value ?? "nil")
             }

             
             DispatchQueue.main.async {
                 self?.tableView.reloadData()
             }

            }

        }
        
        
   }
}
