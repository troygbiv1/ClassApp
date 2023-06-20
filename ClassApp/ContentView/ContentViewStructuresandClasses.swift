//
//  ContentViewStructures.swift
//  ClassApp
//
//  Created by Troy Volanth on 6/21/23.
//

import Foundation
import SwiftUI
import Combine

class SharedClassInfo: ObservableObject {
    @Published var sharedClassInfo: ClassInfo
    
    init() {
        sharedClassInfo = ClassInfo()
    }
}

class ClassInfo: ObservableObject {
    @Published var status: String
    @Published var schedule: Schedule
    @Published var timeUntil: String
    @Published var color: Color
    @Published var color2: Color

    init(status: String = "Loading...",
             schedule: Schedule = Schedule.placeholder,
             timeUntil: String = "00:00:00",
             color: Color = .blue,
             color2: Color = .black) {
            self.status = status
            self.schedule = schedule
            self.timeUntil = timeUntil
            self.color = color
            self.color2 = color2
        }
    func updateClassInfo(classInfo: ClassInfo){
        self.status = classInfo.status
        self.schedule = classInfo.schedule
        self.timeUntil = classInfo.timeUntil
        self.color = classInfo.color
        self.color2 = classInfo.color2
    }
}

struct ClassInfoDecoder: Codable, Equatable, Hashable {
    let numberOfStudents: Int
    let students: [String]
    let classAverage: Int
}

struct RandomStudent {
    
    func randomStudent(classString: String) -> String {
        let classRoom = classRoomData[classString]
        let randomStudent = classRoom!.students.randomElement()!
        return randomStudent
    }
}

