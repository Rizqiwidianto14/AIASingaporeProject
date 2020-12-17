//
//  ViewController.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 16/12/20.
//

import UIKit

class ViewController: UIViewController {
    let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=demo")!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //
        WebServices().getStockData(url: url) { interval in

        }
    }


}

