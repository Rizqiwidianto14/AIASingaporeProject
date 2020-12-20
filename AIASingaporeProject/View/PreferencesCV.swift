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
class PreferencesCV: UIViewController {
    var preferenceVM = PreferenceViewModel()
    var outputDelegate: OutputSizeDelegate?
    @IBOutlet weak var outputSegmented: UISegmentedControl!
    @IBOutlet weak var intradayInterval: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        dismiss(animated: true, completion: nil)
    }
    


}
