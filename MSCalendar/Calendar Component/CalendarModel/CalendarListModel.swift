//
//  CalendarListModel.swift
//  MSCalendar
//
//  Created by AbdulNaveed Soudagar on 31/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class CalendarListModel:NSObject {

    //Calendar List
    var dateListModels:[CalendarModel]? = []
    
    //Event List
    var eventList:[CalendarEvent]? = []
    
    init(dates:[CalendarModel],events:[CalendarEvent]) {
        self.dateListModels = dates
        self.eventList = events
    }

}
