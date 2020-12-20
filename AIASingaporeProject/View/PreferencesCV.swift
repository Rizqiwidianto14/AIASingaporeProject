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
    var preferenceVM = PreferenceViewModel()
    var outputDelegate: OutputSizeDelegate?
    var intervalDelegate: IntervalDelegate?
    @IBOutlet weak var outputSegmented: UISegmentedControl!
    @IBOutlet weak var intradayInterval: UISlider!
    @IBOutlet weak var indicator: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        intradayInterval.addTarget(self, action: #selector(intradaySliderDidChange), for: .valueChanged)

    }
    @objc func intradaySliderDidChange(slider: UISlider){
        let currentValue = Int(slider.value)
        if currentValue == 1{
            preferenceVM.interval = "1min"
        } else if currentValue == 2{
            preferenceVM.interval = "5min"
        } else if currentValue == 3{
            preferenceVM.interval = "15min"
        } else if currentValue == 4{
            preferenceVM.interval = "30min"
        } else if currentValue == 5{
            preferenceVM.interval = "60min"
        }
        indicator.text = "\(preferenceVM.interval)"
    }
    
    @IBAction func outputDidSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            preferenceVM.outputSize = "compact"
            print(preferenceVM.outputSize)
        } else {
            preferenceVM.outputSize = "full"

        }
    }
    
 
    @IBAction func applyButtonPushed(_ sender: UIButton) {
        outputDelegate?.outputChanged(output: preferenceVM.outputSize)
        intervalDelegate?.intervalChanged(time: preferenceVM.outputSize)
        dismiss(animated: true, completion: nil)
    }
    


}
