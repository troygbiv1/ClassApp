//
//  classRoom.swift
//  Teacher Helper
//
//  Created by Troy Volanth on 6/19/23.
//

import Foundation
import SwiftUI


class ClassInfo: ObservableObject {
    @Published var status: String
    @Published var schedule: Schedule
    @Published var timeUntil: String
    @Published var color: Color
    @Published var color2: Color

    init(status: String, schedule: Schedule, timeUntil: String, color: Color, color2: Color) {
        self.status = status
        self.schedule = schedule
        self.timeUntil = timeUntil
        self.color = color
        self.color2 = color2
    }
}

struct ClassInfoDecoder: Codable, Equatable, Hashable {
    let numberOfStudents: Int
    let students: [String]
    let classAverage: Int
}



