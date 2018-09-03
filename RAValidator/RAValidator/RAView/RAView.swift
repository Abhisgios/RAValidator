//
//  RAView.swift
//  RAValidator
//
//  Created by Abhishek Visa on 31/8/18.
//  Copyright © 2018 Abhishek Visa. All rights reserved.
//

import UIKit

public protocol RAValidatorDelegate: class
{
    func responseAfterVerification(string callback:String)
}

public class RAView: UIView {

    @IBOutlet weak var view_Container:UIView!
    @IBOutlet weak var lbl_GeneratedNumber:UILabel!
    var collView:UICollectionView!
    var str_Generated:String = ""
    var str_SelectedNumbers:String = ""
    var timer:Timer!
    var arrNumbers:Array<String> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    let nibName = "RAView"
    var contentView: UIView!
    
    public var numberOfFailedAttempts:Int = 0
    var failedAttempts:Int = 0
    public weak var delegate: RAValidatorDelegate?

    // MARK: Set Up View
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    deinit {
        if timer != nil
        {
            timer.invalidate()
            timer = nil
        }
    }
    
    func setUpView()
    {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(contentView)
        contentView.center = self.center
        
        view_Container.clipsToBounds = true
        let collFrame = CGRect(x: 0, y: 0, width: view_Container.frame.size.width, height: view_Container.frame.size.height)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5C")
                layout.itemSize = CGSize(width: 80, height: 80)
            case 1334, 1920, 2208, 2436:
                print("iPhone 6 or 6+ or X")
                layout.itemSize = CGSize(width: 110, height: 110)
            default:
                print("unknown")
            }
        }
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        collView = UICollectionView(frame: collFrame, collectionViewLayout: layout)
        collView.dataSource = self
        collView.delegate = self
        collView.showsVerticalScrollIndicator = false
        collView.showsHorizontalScrollIndicator = false
        collView.register(Cell_Number.self, forCellWithReuseIdentifier: "CellNumber")
        collView.backgroundColor = UIColor.clear
        
        view_Container.addSubview(collView)
        
        self.getRandomNumberString()
        
        timer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(self.getRandomNumberString), userInfo: nil, repeats: true)
    }
    
    @objc func getRandomNumberString()
    {
        let arrRandomNum:NSArray = NSArray(array: (0..<4).map{ _ in Int(arc4random_uniform(10)) })
        str_Generated = arrRandomNum.componentsJoined(by: "")
        
        lbl_GeneratedNumber.text = str_Generated
        // print("---> ", str_Generated)
        let reversed = String(str_Generated.reversed())
        str_Generated = reversed
        // print("--------- ", str_Generated)
        
        arrNumbers = self.shuffleArray(array: arrNumbers)
        // print("Shuffled List -> ", arrNumbers)
        if collView != nil
        {
            collView.reloadData()
        }
    }
    
    func shuffleArray(array : [String]) -> [String]
    {
        var shuffledArray : [String] = []
        var copyOfArray : [String] = array
        while !copyOfArray.isEmpty {
            let arrayCount : Int = copyOfArray.count
            let randomElement : Int = Int(arc4random_uniform(UInt32(arrayCount)))
            let arraySlice : String = copyOfArray[randomElement]
            shuffledArray.append(arraySlice)
            copyOfArray.remove(at : randomElement)
        }
        return shuffledArray
    }
}

extension RAView: UICollectionViewDataSource, UICollectionViewDelegate
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrNumbers.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let strNumb:String = arrNumbers[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellNumber", for: indexPath) as! Cell_Number
        cell.backgroundColor = UIColor.clear
        // cell.lbl_Title.text = strNumb
        cell.btnTap.setTitle(strNumb, for: .normal)
        cell.btnTap.tag = indexPath.item
        cell.btnTap.addTarget(self, action: #selector(self.btn_NumberTapped(btn:)), for: .touchUpInside)
        return cell
    }
    
    @objc func btn_NumberTapped(btn:UIButton)
    {
        str_SelectedNumbers = str_SelectedNumbers + (btn.titleLabel?.text)!
        
        if str_SelectedNumbers.count == 4
        {
            // print(str_SelectedNumbers)
            if str_SelectedNumbers == str_Generated
            {
                let alertView = UIAlertController(title: "SUCCESS", message: "You're Authorised to proceed", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                  //  print("Do something like Invalidate Timer")
                    if self.timer != nil
                    {
                        self.timer.invalidate()
                        self.timer = nil
                    }

                    self.failedAttempts = 0
                    if self.delegate != nil
                    {
                        self.delegate?.responseAfterVerification(string: "SUCCESS")
                    }
                    
                    self.removeFromSuperview()
                })
                alertView.addAction(action)
              //  self.present(alertView, animated: true, completion: nil)
                self.window?.rootViewController?.present(alertView, animated: true, completion: nil)

            }
            else
            {
                let alertView = UIAlertController(title: "FAILURE", message: "You entered wrong code \n try again!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                   // print("change code Immediately if you want")
                    // self.getRandomNumberString()

                    self.failedAttempts = self.failedAttempts + 1
                    
                    if self.numberOfFailedAttempts != 0
                    {
                        if self.numberOfFailedAttempts == self.failedAttempts
                        {
                            self.removeSelf()
                        }
                    }
                })
                alertView.addAction(action)
                self.window?.rootViewController?.present(alertView, animated: true, completion: nil)
            }
            str_SelectedNumbers = ""
        }
    }
    
    func removeSelf()
    {
        if timer != nil
        {
            self.timer.invalidate()
            self.timer = nil
        }
        
        if self.delegate != nil
        {
            self.delegate?.responseAfterVerification(string: "FAILURE")
        }

        self.removeFromSuperview()
    }
}

