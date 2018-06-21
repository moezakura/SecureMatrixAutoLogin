//
//  PasswordObject.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/21.
//  Copyright © 2018 mox. All rights reserved.
//

import Foundation

struct PasswordObject: Codable {
    let Number: Int
    let IsMatrix: Bool
}

class PasswordManager {
    static func Create(number: Int, isMatrix: Bool) -> PasswordObject {
        return PasswordObject(Number: number, IsMatrix: isMatrix)
    }
    
    static func Parse(text: String) -> Array<PasswordObject> {
        var returnArray:Array<PasswordObject> = []
        let charList = CharList.Get()
        
        text.forEach{
            let char = String($0)
            if let number = Int(char) {
                returnArray.append(PasswordManager.Create(number: number, isMatrix: false))
            }else{
                let index = charList.index(of: char)
                if let _index = index {
                    returnArray.append(PasswordManager.Create(number: _index, isMatrix: true))
                }
            }
        }
        
        return returnArray
    }
    
    static func ToJson(_ object: PasswordObject) -> String{
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            let jsonstr:String = String(data: data, encoding: .utf8)!
            return jsonstr
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
}
