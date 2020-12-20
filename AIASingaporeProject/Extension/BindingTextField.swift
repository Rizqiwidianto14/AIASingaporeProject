//
//  BindingTextField.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 19/12/20.
//

import Foundation
import UIKit

class BindingTextField: UITextField{
    var textChangeClosure: (String) -> () = { _ in }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        if let text = textField.text {
             self.textChangeClosure(text)
        }
    }
    
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChangeClosure = callback
    }

    
}

