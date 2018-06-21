//
//  PasswordCellChild.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/21.
//  Copyright © 2018 mox. All rights reserved.
//

import UIKit

class PasswordCellChild: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    static func load() -> UINib? {
        return UINib(nibName: "PasswordCellChild", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setLabel(text: String){
        label.text = text
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
}
