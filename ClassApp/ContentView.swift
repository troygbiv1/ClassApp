//
//  ContentView.swift
//  Teacher Helper
//
//  Created by Troy Volanth on 6/17/23.
//

import SwiftUI

struct ContentView: View {
    let scheduleStorage = ScheduleStorage()
    @State private var nextClassInfo: (status: String, schedule: Schedule, timeUntil: String, color: Color, color2: Color) = ("", Schedule.placeholder, "00:00:00", Color(red: 33/255, green: 117/255, blue: 155/255), Color(red: 33/255, green: 117/255, blue: 155/255))
    
    func fetchNextClassInfo() {
        // Call the function that returns the Block object
        let nextClass = self.scheduleStorage.loadNextClass()
        
        // Extract the status string and Schedule object from the Block object
        let status = nextClass!.stringValue
        let schedule = nextClass!.schedule
        
        var hour = nextClass?.timeUntil.hour ?? 0
        var minute = nextClass?.timeUntil.minute ?? 0
        var second = nextClass?.timeUntil.second ?? 0
        
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
            color2 = Color(red: 0/255, green: 0/255, blue: 139)
        }
        
        
        
        nextClassInfo = (status, schedule, timerString, color, color2)
        

    }
    
    @State private var showStudent = false
    @State private var studentRandom = ""
    
    var body: some View {
        VStack(spacing:25) {
            Text(studentRandom)
                           .font(.system(size: 40))
                           .foregroundColor(.white)
                           .padding(0.0)
                           .frame(width: 300, height: 55)
                           .background(RoundedRectangle(cornerRadius: 30).foregroundColor(nextClassInfo.color2))
                           .opacity(showStudent ? 1 : 0)
            Button(action: {
                if nextClassInfo.status == "on going"
                {
                    self.disabled(false)
                }
                else {
                    self.disabled(true)
                }
                let randomStudent = RandomStudent()
                studentRandom = randomStudent.randomStudent(classString: nextClassInfo.schedule.name)
                showStudent = true
                
                
            }) {
                RoundedRectangle(cornerRadius: 35)
                    .frame(width: 300, height: 300)
                    .foregroundColor(nextClassInfo.color)
                    .overlay(
                        VStack {
                            Text(nextClassInfo.status)
                                .font(.system(size: 40))
                                .foregroundColor(.black)
                            Text(nextClassInfo.schedule.name)
                                .font(.system(size: 115))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                    )
            }
            RoundedRectangle(cornerRadius: 35)
                .frame(width: 300, height: 85)
                .foregroundColor(nextClassInfo.color2)
                .overlay(
                    Text(nextClassInfo.timeUntil)
                        .font(.system(size:40))
                        .foregroundColor(.white)
                )
        }
        .padding(.top, -45.0)
        .onAppear(){
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                fetchNextClassInfo()
                }
        }
    }
}

    
struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}

