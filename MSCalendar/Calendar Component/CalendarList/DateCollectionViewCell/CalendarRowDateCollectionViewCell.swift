//
//  CalendarRowDateCollectionViewCell.swift
//  collectionviewdate
//
//  Created by AbdulNaveed Soudagar on 23/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class CalendarRowDateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var displayLabel:UILabel!
    
    @IBOutlet weak var monthLabel:UILabel!
    
    @IBOutlet weak var heightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var dotLabel:UILabel!
    
    @IBOutlet weak var displayCurrentLbl:UILabel!
    
    func displayLabelValue(dateVal:String)
    {
        self.displayLabel.text = dateVal 
        self.monthLabel.text = ""
        self.heightConstraint.constant = 0
        self.displayCurrentLbl.isHidden = true
        self.displayLabel.textColor = UIColor.gray
    }

    func displayMonthLabel(dateVal:String,month:String!)
    {
        self.displayLabel.text = dateVal
        self.monthLabel.text = month
        self.heightConstraint.constant = 16
        self.displayCurrentLbl.isHidden = true
        self.displayLabel.textColor = UIColor.gray
    }
    
    func displayCurrentDateLabel ()
    {
        self.displayCurrentLbl.layer.cornerRadius = 15.0
        self.displayCurrentLbl.layer.masksToBounds = true
        self.displayCurrentLbl.isHidden = false
        self.displayLabel.textColor = UIColor.white
    }
}
