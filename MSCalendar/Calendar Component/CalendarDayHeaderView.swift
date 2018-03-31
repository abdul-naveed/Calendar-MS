//
//  CalendarDayHeaderView.swift
//  MSCalendar
//
//  Created by AbdulNaveed Soudagar on 20/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

/**
 * Class Responsible to load the header view with static at top
 * Displaying week day labels like "S,M,T,W,T,F,S"
 **/
class CalendarDayHeaderView: UIView {
    
    // Overriding this method of the UIView,
    // Because this the best place to constraint the labels and headers.
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        //Draw label container
        self.drawLabelContainer()
        
        //Set Bounds
        var frame = self.bounds
        frame.origin.y += 0.0
        frame.size.height = 20.0
        
        //Create frame
        //Logic :
        //        width should be for 7 Labels in a week hence width / 7
        //        height should be divided by 2 for equal spacing and center aligned
        var labelFrame = CGRect(x: 0.0,
                                y: 0.0,
                                width: self.bounds.size.width / 7.0,
                                height: self.bounds.size.height / 2.0)
        
        //Now set the frame by adding the width upon the appened labels X Value
        for eachDayLabel in (self.subviews.first?.subviews)! {
            eachDayLabel.frame = labelFrame
            labelFrame.origin.x += labelFrame.size.width
        }
        
        //draw footer view
        self.drawFooterView()
    }

    
    func drawLabelContainer() {
        
        //Create a container view
        let containerView = UIView()
        
        //loop through to get the label values
        //7...14??? Since we are displaying Sun,Mon.... using modulus
        for index in 7...14 {
            
            //Get the label
            let dayLabel = self.getDayLabel(day: index)
            
            //add to view container
            containerView.addSubview(dayLabel)
        }
        
        //Add the container subview
        self.addSubview(containerView)
    }
    
    func getDayLabel(day:Int) -> UILabel {
        //Formatter needed to get the day names
        //Yes we need this, Nah!!! I don't wanna hardcode, lets rely on date formatter
        let dataFormatter = DateFormatter()
        
        //Compose Label
        let label = UILabel()
        
        //Set Attributes to the label
        label.font = UIFont.systemFont(ofSize: 14)
        
        //Get the first character
        label.text = String(describing: dataFormatter.shortWeekdaySymbols[(day % 7)].first!)
        
        //Further attributes
        label.textColor = UIColor.gray
        label.textAlignment = NSTextAlignment.center
        return label;
    }
    
    func drawFooterView() {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.gray
        self.addSubview(footerView)
        footerView.frame = CGRect(x: 0.0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
    }
}
