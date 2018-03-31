//
//  AgendaTableViewCell.swift
//  collectionviewdate
//
//  Created by AbdulNaveed Soudagar on 23/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {

    //Represented Event Model
    var eventListModel:CalendarEvent? = nil
    
    //Labels
    @IBOutlet weak var eventTitleLabel:UILabel!
    
    //Location
    @IBOutlet weak var locationLabel:UILabel!
    
    //Time Label
    @IBOutlet weak var startTimeLabel:UILabel!
    
    //Method to display the model on the view
    func displayModel() {
        if(eventListModel != nil)
        {
            self.eventTitleLabel.text = eventListModel?.title
            self.locationLabel.text = eventListModel?.location
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let startTime = dateFormatter.string(from: (eventListModel?.startDate)!)
            self.startTimeLabel.text = startTime
        }
    }
    
}
