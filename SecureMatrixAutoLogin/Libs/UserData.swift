//
//  userData.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/21.
//  Copyright © 2018 mox. All rights reserved.
//

import Foundation

class UserData {
    static func savePassword(_ pw: String) {
        UserDefaults.standard.set(pw, forKey: "PASSWORD")
    }
    
    static func getPassword() -> String {
        let password = UserDefaults.standard.string(forKey: "PASSWORD")
        if let _password = password{
            return _password
        }else{
            return ""
        }
    }
}
