//
//  CalendarViewController.swift
//  MSCalendar
//
//  Created by AbdulNaveed Soudagar on 23/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

//MARK:- Calendar Extensions
extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    var startOfWeek: Date? {
        return Calendar.gregorian.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
}


class CalendarViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    var lastDate:Date?
    
    var lastRowCount:Int = 22
    
    var dateRowList:[CalendarListModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialist event list with the start date
        self.lastDate = Date().startOfWeek
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureTableView()
    }
    
    //Method to configure the basic attributes of table view
    func configureTableView()
    {
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 500
        self.tableView.register(UINib(nibName: "CalendarRowTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarRowTableViewCell")
    }
}

//MARK:- Table View Data Source
extension CalendarViewController: UITableViewDataSource {
    
    //Table view wants to know how many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.lastRowCount
    }
    
    //Table view wants to cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarRowTableViewCell", for: indexPath) as! CalendarRowTableViewCell
    
        //Date List Models
        var dateListModel:CalendarListModel?
        
        //Check for the count
        if(indexPath.row >= (self.dateRowList?.count)!)
        {
            //Match Last Dates and get the details
            var dateListRows:[CalendarModel]? = []
            
            //Last date of the week to append further
            let lastDate = self.lastDate
            
            //New dates upon increments
            var newDate:Date? = nil
            
            //set the start date
            let startDate:Date? = self.lastDate
            var endDate:Date? = nil
            
            //For the first week of 7 days
            for idx in 0...6
            {
                newDate = Calendar.current.date(byAdding: .day, value: idx, to: lastDate!)
                let calModel = CalendarModel(date: newDate!)
                dateListRows?.append(calModel)
                
                if idx == 6 {
                    //Set the end date
                    endDate = newDate
                }
            }
            
            //Set back the last date by incrementing for the next updates for the circle
            //Because we always start from zero in the above code
            self.lastDate = Calendar.current.date(byAdding: .day, value: 1, to: newDate!)
            
            //Date List Model created and saved
            dateListModel = CalendarListModel(dates: dateListRows!, events: [])
            
            //set the events for each week of the date
            EventsManager.load(from: startDate!, to: endDate!) { 
                if let events = $0 {
                    dateListModel?.eventList = events
                    cell.reloadDates()
                } else {
                    // There was an error while accessing
                }
            }
    
            //Append Row List
            self.dateRowList?.append(dateListModel!)
        }
        else
        {
            //Get already saved rows
            dateListModel = self.dateRowList![indexPath.row]
        }
        
        //Get the last object
        cell.cellIndexPath = indexPath
        
        //Set the represented Model for each row
        cell.dateListEventModel = dateListModel!
        
        //Reload to display the fresh dates
        cell.reloadDates()
        
        //Closure to expand
        cell.didClickToExpand = { (expandedIndexPath:IndexPath) in
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        return cell
    }
}

//Mark:- Table View Prefetch Data Rows
extension CalendarViewController:UITableViewDataSourcePrefetching {
      func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])
      {
        var lastPath = indexPaths.last
        if(lastPath?.row == self.lastRowCount - 11) {
            self.lastRowCount = self.lastRowCount + 11
            self.tableView.reloadData()
        }
    }
}
