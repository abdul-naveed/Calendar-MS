//
//  CalendarRowTableViewCell.swift
//  collectionviewdate
//
//  Created by AbdulNaveed Soudagar on 22/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit

/**
 * Class Name    : CalendarRowTableViewCell
 * Responsiblity : This is a table view row cell, responsible to load the collection view with its cell in a row.
 **/
class CalendarRowTableViewCell: UITableViewCell {
    
    //Date List Models
    var dateListEventModel:CalendarListModel?
    
    //Collection View to load the dates
    @IBOutlet weak var dateListCollectionView:UICollectionView!
    
    //Events height constraint
    @IBOutlet weak var eventsHeightConstraint:NSLayoutConstraint!
    
    //Events View
    @IBOutlet weak var eventsTableView:UITableView!
    
    //Collapse Button
    @IBOutlet weak var collapseButton:UIButton!
    
    //Closure invoked while the collection view cell is invoked
    var didClickToExpand: ((_ expandedIndexPath:IndexPath) -> Void)?
    
    //Always remember if that was expanded
    var isExpanded:Bool = false
    
    //Cell should know in which index path its been loaded
    var cellIndexPath:IndexPath!
    
    //Class Method
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Configure Collection View for dates
        self.configureCollectionView()
        
        //Configure agenda table view for events and agendas
        self.configureAgendaTableListView()
    }
    
    //MARK:- Calendar Dates Collection View Responsibilities
    func configureCollectionView() {
        
        //Register Cell
        self.dateListCollectionView.register(UINib(nibName: "CalendarRowDateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarRowDateCollectionViewCell")
        
        //Configure data source and delegate
        self.dateListCollectionView.delegate = self
        self.dateListCollectionView.dataSource = self
        
        //Adjust height constaint and view height to ZERO
        self.eventsHeightConstraint.constant = 0
        self.eventsTableView.frame.size.height = 0
    }
    
    //Expand and Collapse
    func toggleExansion()
    {
        if(self.dateListEventModel?.eventList?.count != 0)
        {
            if(self.isExpanded)
            {
                //Adjust height constaint and view height to ZERO
                self.eventsHeightConstraint.constant = 0
                self.eventsTableView.frame.size.height = 0
            }
            else
            {
                let tableView = self.superview as! UITableView
                var rect = tableView.rectForRow(at: self.cellIndexPath)
                rect = rect.offsetBy(dx: -tableView.contentOffset.x, dy: -tableView.contentOffset.y)
                let height = (UIScreen.main.bounds.size.height - rect.origin.y) - 200
                
                //Adjust height constaint and view height to ZERO
                self.eventsHeightConstraint.constant = height
                self.eventsTableView.frame.size.height = height
            }
        
        
            self.isExpanded = !self.isExpanded
            
            //Hide Unhide the expansion button
            self.collapseButton.isHidden = !self.isExpanded
            
            self.eventsTableView.reloadData()
        }
    }
    
    //MARK:- Agenda List View Responsibilities
    func configureAgendaTableListView() {
        
        //Set the data source & delegate, extension and implementation ahead
        self.eventsTableView.dataSource = self
        self.eventsTableView.delegate = self
        
        
        //Register Cell
        self.eventsTableView.register(UINib(nibName: "AgendaTableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaTableViewCell")
        
        //Register header cell
        self.eventsTableView.register(UINib(nibName: "AgendaHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaHeaderTableViewCell")
        
        
        self.eventsTableView.rowHeight = UITableViewAutomaticDimension
        self.eventsTableView.estimatedRowHeight = 500
    }
    
    //MARK:- Collapse Button
    @IBAction func collapse(sender:AnyObject) {
        self.toggleExansion()
        
        //Check for the closure set
        if(self.didClickToExpand != nil) {
            
            //Invoke to update the table view layout
            self.layoutIfNeeded()
            self.didClickToExpand!(self.cellIndexPath)
        }
    }
    
    func reloadDates()
    {
        self.dateListCollectionView.reloadData()
    }
}


//MARK:- Dates
//MARK:- Collection View Data Source
extension CalendarRowTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //7 Days in a week
        if let count = self.dateListEventModel?.dateListModels?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarRowDateCollectionViewCell", for: indexPath) as! CalendarRowDateCollectionViewCell
        
        let model = self.dateListEventModel!.dateListModels![indexPath.row]
        
        //Display cell with month title
        if(model.isCurrentMonth() == false && model.isFirstDateOfMonth() == true)
        {
            cell.displayMonthLabel(dateVal: (model.getDay()), month: model.getMonth())
        }
        else
        {
            cell.displayLabelValue(dateVal: (model.getDay()))
        }
        
        //Background
        if(model.isCurrentMonth())
        {
            cell.backgroundColor = UIColor.white
        }
        else
        {
            cell.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        }
        
        //Dot label
        let eventList = self.dateListEventModel!.eventList!
        cell.dotLabel.isHidden = !(self.eventExistsForDate(date: model.dateObject!, list: eventList))
        
        //Display Current Date Label
        if(model.isCurrentDate())
        {
            cell.displayCurrentDateLabel()
        }
        
        return cell
    }
    
    
    func eventExistsForDate(date:Date,list:[CalendarEvent]) -> Bool {
        var eventExist:Bool = false
        for evnt in list {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let firstDateStr = dateFormatter.string(from: date)
            let secondDateStr = dateFormatter.string(from: evnt.startDate)
            
            if(firstDateStr == secondDateStr)
            {
               eventExist = true
               break
            }
        }
        return eventExist
    }
}


//MARK:- Collection View Delegate
extension CalendarRowTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Toggle Expansion
        self.toggleExansion()
        
        //Check for the closure set
        if(self.didClickToExpand != nil) {
            
            //Invoke to update the table view layout
            self.layoutIfNeeded()
            self.didClickToExpand!(self.cellIndexPath)
        }
    }
}

//MARK:- Collection View Layout Delegate
extension CalendarRowTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Divide it by 7 in the fit for the days in a week
        let fitWidth = collectionView.bounds.width/7.0
        
        //Thats a square
        let fitHeight = fitWidth
        
        return CGSize(width: fitWidth , height: fitHeight + 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK:- Events
//MARK:- Table View Data Source
extension CalendarRowTableViewCell: UITableViewDataSource {
    
    //Sections??
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Rows??
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dateListEventModel?.eventList?.count)!
    }
    
    //Cell??
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
        if let eventListModel = self.dateListEventModel?.eventList![indexPath.row] {
            cell.eventListModel = eventListModel
            cell.displayModel()
        }
        return cell
    }
}

//MARK:- Table View Delegate
extension CalendarRowTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "AgendaHeaderTableViewCell") as! AgendaHeaderTableViewCell
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}
