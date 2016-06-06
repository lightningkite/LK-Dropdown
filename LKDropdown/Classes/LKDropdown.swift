//
//  LKTextFieldDropDown.swift
//  HammerPrice
//
//  Created by Kevin Mann on 3/16/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//


import UIKit


class LKDropdown: UITextField {
    
    var picker = UIPickerView()
    
    var options:[(String, String)] = []
    
    var selectedValue:String?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        picker.delegate = self
        picker.dataSource = self
        inputView = picker
        let keyboardDoneButtonShow = UIToolbar(frame: CGRectMake(0, 0,  inputView!.frame.size.width, inputView!.frame.size.height/5))
        keyboardDoneButtonShow.barStyle = UIBarStyle .BlackTranslucent
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(UITextFieldDelegate.textFieldShouldReturn(_:)))
        doneButton.tintColor = UIColor.whiteColor()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let toolbarButton = [flexSpace,doneButton]
        keyboardDoneButtonShow.setItems(toolbarButton, animated: false)
        inputAccessoryView = keyboardDoneButtonShow
        if let firstChoice = options.first {
            selectedValue = firstChoice.0
            text = firstChoice.1
        }
        if let paddingImage = UIImage(named: "DropdownIndicator") {
            let imageView = UIImageView(frame: CGRectMake(0, 0, 20, frame.height))
            imageView.contentMode = .ScaleAspectFit
            imageView.image = paddingImage.imageWithRenderingMode(.AlwaysTemplate)
            imageView.tintColor = tintColor
            let paddingView = UIView(frame: CGRectMake(0, 0, 25, frame.height))
            paddingView.addSubview(imageView)
            rightView = paddingView
            rightViewMode = UITextFieldViewMode.Always
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        return false
    }
    
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRectZero
    }
    
}

extension LKDropdown: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if options[row].0 == "" {
            selectedValue = ""
            text = ""
        } else {
            selectedValue = options[row].0
            text = options[row].1
        }
        
    }
    
    
}

extension LKDropdown: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].1
    }
    
}