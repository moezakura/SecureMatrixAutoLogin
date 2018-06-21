//
//  CharList.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/21.
//  Copyright © 2018 mox. All rights reserved.
//

import Foundation

class CharList {
    static func Get() -> Array<String>{
        var charList: Array<String> = []
        
        // a-z
        for i in 97...122 {
            let char = UnicodeScalar(i)
            charList.append(String(char!))
        }
        
        // A-Z
        for i in 65...90 {
            let char = UnicodeScalar(i)
            charList.append(String(char!))
        }
        
        // Other
        let otherStr = "-/:;()$&@.,?!"
        otherStr.forEach {
            charList.append(String($0))
        }
        
        return charList
    }
}
