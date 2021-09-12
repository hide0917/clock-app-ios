//
//  ContentView.swift
//  ClockApp
//
//  Created by Hidemitsu Shmizu on 2021/09/13.
//

import SwiftUI

var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height

struct ContentView: View {
    @State var hour = Calendar.current.component(.hour, from: Date())
    @State var minute = Calendar.current.component(.minute, from: Date())
    @State var second = Calendar.current.component(.second, from: Date())

    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(.lightGray).edgesIgnoringSafeArea(.all)

            Circle()
                .frame(width: screenWidth * 4/5, height: screenWidth * 4/5)
                .shadow(color: Color(.lightGray), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -5, y: -5)
                .shadow(color: Color(.gray), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
            Circle()
                .fill(Color(.lightGray))
                .frame(width: screenWidth * 4/5, height: screenWidth * 4/5)
                .overlay(Circle()
                            .stroke(Color(.gray), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2).mask(Circle().fill(LinearGradient(gradient: Gradient(colors: [Color(.gray), .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))))
                .overlay(Circle()
                    .stroke(Color(.black), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2).mask(Circle().fill(LinearGradient(gradient: Gradient(colors: [Color(.gray), .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))))

            ForEach(0..<12) {i in
                ClockHandsView(color: .black, lineWidth: 2)
                    .scaleEffect(0.1)
                    .offset(x: 0, y: -(screenWidth * 2/5 - 30))
                    .rotationEffect(.degrees(Double(30 * i)))
            }

            ZStack {
                ClockHandsView(color: .black, lineWidth: 4)
                    .scaleEffect(0.7)
                    .rotationEffect(.degrees(Double(hour * 30)))
                ClockHandsView(color: .black, lineWidth: 4)
                    .rotationEffect(.degrees(Double(minute * 6)))
                ClockHandsView(color: .red, lineWidth: 2)
                    .scaleEffect(0.8)
                    .rotationEffect(.degrees(Double(second * 6)))
            }
        }.onReceive(timer) { _ in
            self.hour = Calendar.current.component(.hour, from: Date())
            self.minute = Calendar.current.component(.minute, from: Date())
            self.second = Calendar.current.component(.second, from: Date())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ClockHandsView: View {
        @State var color: UIColor
        @State var lineWidth: CGFloat

    var body: some View {
        Path{path in
           path.move(to: CGPoint(x: screenWidth/2, y: screenHeight/2))
           path.addLine(to:CGPoint(x: screenWidth/2, y: screenHeight/2 - (screenWidth * 2/5)))
       }.stroke(Color(color), lineWidth: lineWidth)
    }
}
