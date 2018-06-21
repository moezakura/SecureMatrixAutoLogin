//
//  SettingsViewController.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/21.
//  Copyright © 2018 mox. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var passwordParent: UIScrollView!
    @IBOutlet weak var passwordType: UITextField!
    
    var passwordCells: Array<PasswordCell>! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0...3{
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
    }
    
    func insertChar (_ insertText: String){
        if let range = passwordType.selectedTextRange {
            passwordType.replace(range, withText: insertText)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
