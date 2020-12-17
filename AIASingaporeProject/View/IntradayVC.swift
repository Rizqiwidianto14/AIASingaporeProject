//
//  ViewController.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 16/12/20.
//

import UIKit

class IntradayVC: UIViewController {
    let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=BBCA&interval=5min&apikey=JD109RV7JNDNU0Z0")!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //
        IntradayServices().getStockData(url: url) { interval in

        }
    }


}

