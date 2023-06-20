//
//  ContentView.swift
//  Teacher Helper
//
//  Created by Troy Volanth on 6/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showStudent = false
    @State private var studentRandom = ""
    @State var buttonDisabled = true
    @State fileprivate var nextClassInfo = fetchNextClassInfo()
    
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
                studentRandom = buttonFunc(nextClassName: nextClassInfo.schedule.name)
                showStudent = true
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
                .frame(width: 300, height: 75)
                .foregroundColor(nextClassInfo.color2)
                .overlay(
                    Text(nextClassInfo.timeUntil)
                        .font(.system(size:40))
                        .foregroundColor(.white)
                )
                Button(action: {
                }){
                    RoundedRectangle(cornerRadius: 35)
                        .frame(width: 120, height: 50)
                        .foregroundColor(nextClassInfo.color2)
                        .overlay(
                            Text("Roll Call")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(0.0)
                                .frame(width: 100, height: 55)
                        )
                    //  .opacity(showStudent ? 1 : 0)

            }
        }
        
        
        
        
        
        
        .onAppear(){
                    nextClassInfo.updateClassInfo(classInfo: fetchNextClassInfo())
                    var statuesUpdate = ""
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        nextClassInfo = fetchNextClassInfo()
                        let nextClassInfo2 = fetchNextClassInfo()
                        if statuesUpdate != nextClassInfo2.status {
                            showStudent = false
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
        }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

