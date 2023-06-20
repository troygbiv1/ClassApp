//
//  classRoom.swift
//  Teacher Helper
//
//  Created by Troy Volanth on 6/19/23.
//

import Foundation


struct ClassInfo: Codable, Equatable, Hashable {
    let numberOfStudents: Int
    let students: [String]
    let classAverage: Int
}


