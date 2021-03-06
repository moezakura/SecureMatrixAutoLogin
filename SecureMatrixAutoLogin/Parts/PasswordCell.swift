//
//  PasswordCell.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/21.
//  Copyright © 2018 mox. All rights reserved.
//

import UIKit

class PasswordCell: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    var startIndex = 0
    var charList: Array<String>! = []
    var inserEvent: ((String)->Void)?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        setChars()
        
        self.register(PasswordCellChild.load(), forCellWithReuseIdentifier: "cell")
        self.dataSource = self
        self.delegate = self
    }
    
    func setChars(){
        charList = CharList.Get()
    }
    
    public func setTapEvent(_ event: @escaping (String)->()){
        inserEvent = event
    }
    
    func set(_ _startIndex: Int) {
        startIndex = _startIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! PasswordCellChild
        cell.setLabel(text: charList[startIndex + indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(charList[startIndex + indexPath.row])
        if let _inserEvent = inserEvent {
            _inserEvent(charList[startIndex + indexPath.row])
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    static func load(owner: UIView) -> PasswordCell {
        return UINib(nibName: "PasswordCell", bundle: nil).instantiate(withOwner: owner, options: nil).first as! PasswordCell
    }
    
}
