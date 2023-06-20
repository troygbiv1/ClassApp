//
//  ContentViewFunctions.swift
//  ClassApp
//
//  Created by Troy Volanth on 6/21/23.
//

import Foundation
import SwiftUI

func buttonFunc(nextClassName: String) -> String {
    let randomStudent = RandomStudent()
    let studentRandom = randomStudent.randomStudent(classString: nextClassName)
    return studentRandom
}

func fetchNextClassInfo() -> ClassInfo {
    var nextClassInfo: ClassInfo = ClassInfo(status: "", schedule: Schedule.placeholder, timeUntil: "00:00:00", color: Color(red: 33/255, green: 117/255, blue: 155/255), color2: Color(red: 33/255, green: 117/255, blue: 155/255))
    let scheduleStorage = ScheduleStorage()
    // Call the function that returns the Block object
    let nextClass = scheduleStorage.loadNextClass()
    
    // Extract the status string and Schedule object from the Block object
    let status = nextClass!.stringValue
    let schedule = nextClass!.schedule
    
    let hour = nextClass?.timeUntil.hour ?? 0
    let minute = nextClass?.timeUntil.minute ?? 0
    let second = nextClass?.timeUntil.second ?? 0
    
    var timerString = String(format: "%02d:%02d:%02d", hour, minute, second)
    
    var color = nextClassInfo.color
    var color2 = nextClassInfo.color
    
    
    if status == "coming up" {
        color = Color(red: 144/255, green: 238/255, blue: 144/255)
        color2 = Color(red: 0/255, green: 128/255, blue: 0/255)
    } else if status == "Done for\nthe Day!" {
        color = Color(red: 255/255, green: 165/255, blue: 0)
        color2 = Color(red: 147/255, green: 112/255, blue: 219)
        timerString = "--:--"
    } else {
        color = Color(red: 135/255, green: 206/255, blue: 250/255)
        color2 = Color(red: 0/255, green: 0/255, blue: 139/255)
    }
    
    
    nextClassInfo = ClassInfo(status: status, schedule: schedule, timeUntil: timerString, color: color, color2: color2)
    return nextClassInfo
}



