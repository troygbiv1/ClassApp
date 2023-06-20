//
//  ContentView.swift
//  Teacher Helper
//
//  Created by Troy Volanth on 6/17/23.
//

import SwiftUI

private var showStudent = false
private var studentRandom = ""

func buttonFunc(nextClassName: String) {
    let randomStudent = RandomStudent()
    studentRandom = randomStudent.randomStudent(classString: nextClassName)
    showStudent = true
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
        color2 = Color(red: 0/255, green: 0/255, blue: 139)
    }
    
    
    nextClassInfo = ClassInfo(status: status, schedule: schedule, timeUntil: timerString, color: color, color2: color2)
    return nextClassInfo
}


struct ContentView: View {
    @State var studentRandom = ""
    @State var buttonDisabled = true
    
    @State var nextClassInfo = fetchNextClassInfo()

    
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
                buttonFunc(nextClassName: nextClassInfo.schedule.name)
            })
                   {
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
            .disabled(buttonDisabled)
            RoundedRectangle(cornerRadius: 35)
                .frame(width: 300, height: 85)
                .foregroundColor(nextClassInfo.color2)
                .overlay(
                    Text(nextClassInfo.timeUntil)
                        .font(.system(size:40))
                        .foregroundColor(.white)
                )
                .onAppear(){
                    var statuesUpdate = ""
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        let nextClassInfo = fetchNextClassInfo()
                        let nextClassInfo2 = fetchNextClassInfo()
                        if statuesUpdate != nextClassInfo2.status {
                            if nextClassInfo2.status == "on going" {
                                statuesUpdate = nextClassInfo2.status
                                buttonDisabled = false
                            } else {
                                buttonDisabled = true
                                statuesUpdate = nextClassInfo2.status
                            }
                        }
                        }
                    }
                }
        .padding(.top, -45.0)
        }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
