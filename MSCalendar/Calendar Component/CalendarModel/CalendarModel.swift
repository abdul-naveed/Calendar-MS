//
//  CalendarModel.swift
//  MSCalendar
//
//  Created by AbdulNaveed Soudagar on 29/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

class CalendarModel: NSObject {
   
    //Date Object for each cell
    var dateObject:Date?
    
    //Construtor to initialise the date
    init(date:Date)
    {
        self.dateObject = date
    }
    
    
    //Get the day of the dateObject set
    func getDay()->String
    {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd"
        let todayDate = formatter.string(from: self.dateObject!)
        return todayDate
    }
    
    
    //Get the month of the dateObject set
    func getMonth()->String
    {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MMM"
        let todayDate = formatter.string(from: self.dateObject!)
        return todayDate
    }
    
    
    //Check whether the set dateObject is of current Month running!!!
    func isCurrentMonth()->Bool {
        return Calendar.current.isDate(Date(), equalTo: dateObject!, toGranularity: .month)
    }
    
    
    //Check whether the dateObject is the first date of the month
    func isFirstDateOfMonth()->Bool {
        if(dateObject?.daysBetweenDate(toDate: startOfMonth()) == 0)
        {
            return true
        }
        return false
    }
    
    
    //Return the start month of the date from the dateObject
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: dateObject!)))!
    }
    
    //is Current Date
    func isCurrentDate() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let firstDateStr = dateFormatter.string(from: dateObject!)
        let secondDateStr = dateFormatter.string(from: Date())
        
        if(firstDateStr == secondDateStr)
        {
            return true
        }
        return false
    }
}
