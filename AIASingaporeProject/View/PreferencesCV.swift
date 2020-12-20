//
//  SettingsVC.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 17/12/20.
//

import UIKit


protocol OutputSizeDelegate{
    func outputChanged(output: String)
}

protocol IntervalDelegate{
    func intervalChanged(time: String)
}
class PreferencesCV: UIViewController {
    var outputDelegate: OutputSizeDelegate?
    var intervalDelegate: IntervalDelegate?
    let userDefaults = UserDefaults()
    @IBOutlet weak var secretTextField: UITextField!
    
    var outputSize = "compact"
    var interval = "5min"
    
    @IBOutlet weak var outputSegmented: UISegmentedControl!
    @IBOutlet weak var intradayInterval: UISlider!
    @IBOutlet weak var indicator: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let intervalDefault = userDefaults.value(forKey: "interval") as? String{
            indicator.text = "\(intervalDefault)"
            interval = intervalDefault
        }
        
       
        intradayInterval.addTarget(self, action: #selector(intradaySliderDidChange), for: .valueChanged)



    }
    @objc func intradaySliderDidChange(slider: UISlider){
        let currentValue = Int(slider.value)
        if currentValue == 1{
            interval = "1min"
        } else if currentValue == 2{
            interval = "5min"
        } else if currentValue == 3{
            interval = "15min"
        } else if currentValue == 4{
            interval = "30min"
        } else if currentValue == 5{
            interval = "60min"
        }
        indicator.text = "\(interval)"
 
        
    }
    
    @IBAction func outputDidSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            outputSize = "compact"
        } else {
            outputSize = "full"
        }
        userDefaults.setValue(sender.selectedSegmentIndex, forKey: "outputSize")


    }
    
 
    @IBAction func applyButtonPushed(_ sender: UIButton) {
        outputDelegate?.outputChanged(output: outputSize)
        intervalDelegate?.intervalChanged(time: outputSize)
        userDefaults.setValue(interval, forKey: "interval")

        dismiss(animated: true, completion: nil)
    }
    


}
