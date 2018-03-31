//
//  EventsManager.swift
//  MSCalendar
//
//  Created by AbdulNaveed Soudagar on 29/03/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import UIKit
import EventKit

public struct CalendarEvent {
    let title: String
    let startDate: Date
    let endDate:Date
    let allDay:Bool
    let location:String
}

open class EventsManager {
    private static let store = EKEventStore()
    
    static func load(from fromDate: Date, to toDate: Date, complete onComplete: @escaping ([CalendarEvent]?) -> Void) {
        
        let q = DispatchQueue.main
        guard EKEventStore.authorizationStatus(for: .event) == .authorized else {
            
            return EventsManager.store.requestAccess(to: EKEntityType.event, completion: {(granted, error) -> Void in
                guard granted else {
                    return q.async { onComplete(nil) }
                }
                EventsManager.fetch(from: fromDate, to: toDate) { events in
                    q.async { onComplete(events) }
                }
            })
        }
        
        EventsManager.fetch(from: fromDate, to: toDate) { events in
            q.async { onComplete(events) }
        }
    }
    
    private static func fetch(from fromDate: Date, to toDate: Date, complete onComplete: @escaping ([CalendarEvent]) -> Void) {
        
        //Chronological order
        let predicate = store.predicateForEvents(withStart: fromDate, end: toDate, calendars: nil)
        
        let secondsFromGMTDifference = TimeInterval(TimeZone.current.secondsFromGMT())
        
        let events = store.events(matching: predicate).map {
            return CalendarEvent(
                title:      $0.title,
                startDate:  $0.startDate.addingTimeInterval(secondsFromGMTDifference),
                endDate:    $0.endDate.addingTimeInterval(secondsFromGMTDifference),
                allDay:     $0.isAllDay,
                location:   $0.location!
            )
        }
        
        onComplete(events)
    }
}
