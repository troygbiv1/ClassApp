//
//  ScheduleStorage.swift
//  Teacher Helper
//
//  Created by Troy Volanth on 6/17/23.
//
import SwiftUI
import Foundation

struct Schedule: Identifiable {
    static var placeholder: Schedule {
            return Schedule(name: "", dayOfWeek: 1, startTime: "00:00", endTime: "00:00")
        }
    let id = UUID()
    let name: String
    let dayOfWeek: Int
    let startTime: String
    let endTime: String
}

struct Block {
    let schedule: Schedule
    let stringValue: String
    let timeUntil: DateComponents
}

struct ScheduleStorage {
    private let userDefaultsKey = "classSchedule"
    
    let scheduleArray: [Schedule] = [
        Schedule(name: "7.1", dayOfWeek: 2, startTime: "08:00:00", endTime: "08:50:00"),
        Schedule(name: "8.2", dayOfWeek: 2, startTime: "08:50:00", endTime: "9:40:00"),
        Schedule(name: "8.1", dayOfWeek: 2, startTime: "09:55:00", endTime: "10:45:00"),
        Schedule(name: "8.3", dayOfWeek: 2, startTime: "11:35:00", endTime: "12:25:00"),
        Schedule(name: "7.3", dayOfWeek: 2, startTime: "13:30:00", endTime: "14:20:00"),
        Schedule(name: "7.3", dayOfWeek: 3, startTime: "08:00:00", endTime: "08:50:00"),
        Schedule(name: "8.3", dayOfWeek: 3, startTime: "09:55:00", endTime: "10:45:00"),
        Schedule(name: "7.2", dayOfWeek: 3, startTime: "10:45:00", endTime: "11:35:00"),
        Schedule(name: "7.1", dayOfWeek: 4, startTime: "13:30:00", endTime: "22:45:00"),
    ]
    
    func loadNextClass() -> Block? {
        let currentWeekday = Calendar.current.component(.weekday, from: Date())
        
        let todaysClasses = scheduleArray.filter { block in
            block.dayOfWeek == currentWeekday
        }
        let nextClass = timeSorter(schedule: todaysClasses)
        return nextClass
    }
    
    func timeSorter (schedule: [Schedule]) -> Block? {
        let currentTime = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let adjustedTimeString = dateFormatter.string(from: currentTime)
        
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let calendar = Calendar.current
        let dateTime = dateFormatter.date(from: adjustedTimeString)
        var timeUntil = calendar.dateComponents([.hour, .minute, .second], from: Date())
        
        for block in schedule {
            let startTime = dateFormatter.date(from: block.startTime)
            let endTime = dateFormatter.date(from: block.endTime)
            let calendar = Calendar.current
            
            if startTime! <= dateTime! && dateTime! <= endTime! {
                timeUntil = calendar.dateComponents([.hour, .minute, .second], from: dateTime!, to: endTime!)
                let blockFinal = Block(schedule: block, stringValue: "on going", timeUntil: timeUntil)
                return blockFinal // Class is already happening
            }
            if startTime! > dateTime! {
                timeUntil = calendar.dateComponents([.hour, .minute, .second], from: dateTime!, to: startTime!)
                let blockFinal = Block(schedule: block, stringValue: "coming up", timeUntil: timeUntil)
                return blockFinal // Next class
            }
        }
        let noClassesBlock = Block(schedule: Schedule.placeholder, stringValue: "Done for\nthe Day!", timeUntil: timeUntil )
        return noClassesBlock
    }
}



