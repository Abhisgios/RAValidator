//
//  Cell_Number.swift
//  RAValidator
//
//  Created by Abhishek Visa on 31/8/18.
//  Copyright © 2018 Abhishek Visa. All rights reserved.
//

import UIKit

public class Cell_Number: UICollectionViewCell {

    let viewBk: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5C")
                view.layer.cornerRadius = 35
            case 1334, 1920, 2208, 2436:
                print("iPhone 6 or 6+ or X")
                view.layer.cornerRadius = 45
            default:
                print("unknown")
            }
        }
        
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*
    let lbl_Title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27)
        label.textColor = UIColor.black
        label.text = "A"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    */
    
    let btnTap: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5C")
                btn.layer.cornerRadius = 35
            case 1334, 1920, 2208, 2436:
                print("iPhone 6 or 6+ or X")
                btn.layer.cornerRadius = 45
            default:
                print("unknown")
            }
        }
        btn.setTitle("A", for: .normal)
        btn.titleLabel?.font =  .systemFont(ofSize: 27)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.masksToBounds = true        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        backgroundColor = UIColor.clear
        
        addSubview(viewBk)
      //  addSubview(lbl_Title)
        addSubview(btnTap)
        
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5C")
                viewBk.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
                viewBk.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
                viewBk.widthAnchor.constraint(equalToConstant: 70).isActive = true
                viewBk.heightAnchor.constraint(equalToConstant: 70).isActive = true

                btnTap.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
                btnTap.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
                btnTap.widthAnchor.constraint(equalToConstant: 70).isActive = true
                btnTap.heightAnchor.constraint(equalToConstant: 70).isActive = true

            case 1334, 1920, 2208, 2436:
                print("iPhone 6 or 6+ or X")
                viewBk.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
                viewBk.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
                //  viewBk.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
                // viewBk.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20).isActive = true
                viewBk.widthAnchor.constraint(equalToConstant: 90).isActive = true
                viewBk.heightAnchor.constraint(equalToConstant: 90).isActive = true
               
                btnTap.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
                btnTap.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
                btnTap.widthAnchor.constraint(equalToConstant: 90).isActive = true
                btnTap.heightAnchor.constraint(equalToConstant: 90).isActive = true

            default:
                print("unknown")
            }
        }
        
//        lbl_Title.leftAnchor.constraint(equalTo: leftAnchor, constant: 47).isActive = true
//        lbl_Title.centerYAnchor.constraint(equalTo: viewBk.centerYAnchor).isActive = true
//        lbl_Title.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        lbl_Title.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
}
