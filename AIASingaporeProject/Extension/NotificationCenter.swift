//
//  BindingSegmentedControl.swift
//  AIASingaporeProject
//
//  Created by Rizqi Imam Gilang Widianto on 20/12/20.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
