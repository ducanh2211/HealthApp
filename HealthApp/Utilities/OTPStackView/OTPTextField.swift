//
//  OTPTextField.swift
//  HealthApp
//
//  Created by Đức Anh Trần on 08/06/2023.
//

import UIKit

class OTPTextField: UITextField {

    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?

    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
    }

}
