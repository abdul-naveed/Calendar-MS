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
    
    func displayLabelValue(dateVal:String)
    {
        self.displayLabel.text = dateVal
        self.monthLabel.text = ""
        self.heightConstraint.constant = 0
//        self.displayLabel.layer.cornerRadius = 55/2
//        self.displayLabel.clipsToBounds = true
//        self.displayLabel.layer.backgroundColor = UIColor.blue.cgColor
//        self.displayLabel.layer.masksToBounds = true
//        self.displayLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func displayMonthLabel(dateVal:String,month:String!)
    {
        self.displayLabel.text = dateVal
        self.monthLabel.text = month
        self.heightConstraint.constant = 16
    }
}
