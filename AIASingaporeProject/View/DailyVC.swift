//
//  DailyVC.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 17/12/20.
//

import UIKit

class DailyVC: UIViewController {
    var dailyListVM = DailyListViewModel()
    var arrayOfKeysOne = [String]()
    var arrayOfKeysTwo = [String]()
    @IBOutlet weak var firstTextField: BindingTextField!{
        didSet{
            firstTextField.bind{ self.dailyListVM.firstSymbol = $0 }
        }
    }
    @IBOutlet weak var secondTextField: BindingTextField!{
        didSet{
            secondTextField.bind{ self.dailyListVM.secondSymbol = $0 }
        }
    }
    
    
    
  
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
   

    
    @IBAction func compareButtonPressed(){
        setUp()
    }
    
    
    @IBAction func preferenceButtonPressed(_ sender: Any) {
        let selectedVC = storyboard?.instantiateViewController(identifier: "PreferencesCV") as! PreferencesCV
        selectedVC.outputDelegate = self
        present(selectedVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        

    }
    

}


extension DailyVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfKeysTwo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as? DailyCell else {
            fatalError("DailyTableView not found")
        }
        cell.symbolLabelOne.text = dailyListVM.firstSymbol
        cell.symbolLabelTwo.text = dailyListVM.secondSymbol
        
        cell.dateLabel.text = arrayOfKeysTwo[indexPath.row]
        cell.openValueOne.text = dailyListVM.openOne[indexPath.row]
        cell.openValueTwo.text = dailyListVM.openTwo[indexPath.row]
        cell.lowValueOne.text = dailyListVM.lowOne[indexPath.row]
        cell.lowValueTwo.text = dailyListVM.lowTwo[indexPath.row]
        return cell
        
    }
    
    
}

extension DailyVC: OutputSizeDelegate {
    func outputChanged(output: String) {
        dailyListVM.outputSize = output
    }
}

extension DailyVC{
    func setUp() {
        
        let firstSymbol = self.dailyListVM.firstSymbol
        let secondSymbol = self.dailyListVM.secondSymbol
        let firstURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(firstSymbol)&apikey=JD109RV7JNDNU0Z0&outputsize=\(dailyListVM.outputSize)")!
        let secondURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(secondSymbol)&apikey=JD109RV7JNDNU0Z0&outputsize=\(dailyListVM.outputSize)")!
       let firstResource = Resource<DailyViewModel>(url: firstURL) { data in
        
           let dailyVM = try? JSONDecoder().decode(DailyViewModel.self, from: data)
           return dailyVM
       }
        let secondResource = Resource<DailyViewModel>(url: secondURL) { data in
         
            let dailyVM = try? JSONDecoder().decode(DailyViewModel.self, from: data)
            return dailyVM
        }
        

       Webservice().load(resource: firstResource) { [weak self] result in
           if let dailyVM = result {
            
            let dict = dailyVM.timeSeriesDaily
            let myKeys: [String] = dict.map{String($0.key)}
            let dateFormatter = DateFormatter()
            var arrayOfDate = [String]()
            self?.dailyListVM.openOne.removeAll()
            self?.dailyListVM.lowOne.removeAll()
            
            for element in myKeys{
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: element)
                let newDate = dateFormatter.string(from: date!)
                arrayOfDate.append(newDate)
            }
            let sortedArray = arrayOfDate.sorted{dateFormatter.date(from: $0) ?? Date() > dateFormatter.date(from: $1) ?? Date()}
            for element in sortedArray{
                self?.dailyListVM.openOne.append(dailyVM.timeSeriesDaily[element]?.open.value ?? "nil")
                self?.dailyListVM.lowOne.append(dailyVM.timeSeriesDaily[element]?.low.value ?? "nil")
                dateFormatter.dateFormat = "yyyy-MM-dd "
                let date = dateFormatter.date(from: element)
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let newDate = dateFormatter.string(from: date!)
                self?.arrayOfKeysOne.append(newDate)
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
                let dateFormatter = DateFormatter()
                var arrayOfDate = [String]()
                self?.dailyListVM.openTwo.removeAll()
                self?.dailyListVM.lowTwo.removeAll()
                for element in myKeys{
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: element)
                    let newDate = dateFormatter.string(from: date!)
                    arrayOfDate.append(newDate)
                }
                let sortedArray = arrayOfDate.sorted{dateFormatter.date(from: $0) ?? Date() > dateFormatter.date(from: $1) ?? Date()}
                for element in sortedArray{
                    self?.dailyListVM.openTwo.append(dailyVM.timeSeriesDaily[element]?.open.value ?? "nil")
                    self?.dailyListVM.lowTwo.append(dailyVM.timeSeriesDaily[element]?.low.value ?? "nil")
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: element)
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let newDate = dateFormatter.string(from: date!)
                    self?.arrayOfKeysTwo.append(newDate)
                }

             
             DispatchQueue.main.async {
                 self?.tableView.reloadData()
             }

            }

        }
        
        
   }
}

