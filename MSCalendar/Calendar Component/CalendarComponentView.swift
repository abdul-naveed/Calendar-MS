//
//  CalendarComponentView.swift
//  MSCalendar
//
//  Created by AbdulNaveed Soudagar on 21/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class CalendarComponentView: UIView {

    //Top Header view to display days
    var topHeaderView: CalendarDayHeaderView!
    
    //Container collection view to display the dates of year and the month
    var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialiseView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let headerFrame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: 20)
        self.topHeaderView.frame = headerFrame;
    }
    // MARK: Create Subviews
    private func initialiseView() {
        self.topHeaderView = CalendarDayHeaderView(frame:CGRect.zero)
        self.addSubview(self.topHeaderView)
    }

}
