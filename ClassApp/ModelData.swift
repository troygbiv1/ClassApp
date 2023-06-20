//
//  ModelData.swift
//  Teacher Helper
//
//  Created by Troy Volanth on 6/19/23.
//

import Foundation

var classRoomData: [String: ClassInfoDecoder] = load("classRoomData.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

struct RandomStudent {
    
    func randomStudent(classString: String) -> String {
        let classRoom = classRoomData[classString]
        let randomStudent = classRoom!.students.randomElement()!
        return randomStudent
    }
}
