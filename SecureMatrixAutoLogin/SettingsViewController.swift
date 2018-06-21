//
//  SettingsViewController.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/21.
//  Copyright © 2018 mox. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var passwordParent: UIScrollView!
    @IBOutlet weak var passwordType: UITextField!
    @IBOutlet weak var selectStatus: UISegmentedControl!
    
    var passwordCells: Array<PasswordCell>! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        passwordType.delegate = self
        
        for i in 0...3 {
            let passwordCell = PasswordCell.load(owner: passwordParent)
            passwordCell.set(i * 16)
            passwordCell.setTapEvent(self.insertChar)
            passwordCells.append(passwordCell)
            
            let oldRect = passwordCell.frame
            passwordCell.frame = CGRect(x: (oldRect.minX + CGFloat(i) * (oldRect.width + 10)), y: oldRect.minY, width: oldRect.width, height: oldRect.height)
            passwordParent.addSubview(passwordCell)
        }
        let lastPasswordCellRect = passwordCells.last?.frame
        passwordParent.contentSize = CGSize(width: ((lastPasswordCellRect?.width)! + 10) * CGFloat(passwordCells.count),height: (lastPasswordCellRect?.height)!)
        
        passwordType.text = UserData.getPassword()
        debugPrint(UserData.getPassword())
        
        let selectIndex = UserData.getSelectStatus()
        selectStatus.selectedSegmentIndex = selectIndex
        statusChange(selectIndex)
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        statusChange(sender.selectedSegmentIndex)
    }
    
    func statusChange(_ status: Int){
        passwordCells.last?.isHidden = (status == 0) ? true : false
        let count = (status == 0) ? passwordCells.count - 1 : passwordCells.count
        UserData.saveSelectStatus(status)
        
        let lastPasswordCellRect = passwordCells.last?.frame
        passwordParent.contentSize = CGSize(width: ((lastPasswordCellRect?.width)! + 10) * CGFloat(count),height: (lastPasswordCellRect?.height)!)
    }
    
    func insertChar (_ insertText: String){
        if let range = passwordType.selectedTextRange {
            passwordType.replace(range, withText: insertText)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        savePassword()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        savePassword()
    }
    
    func savePassword(){
        if let password = passwordType.text{
            UserData.savePassword(password)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
