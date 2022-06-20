//
//  SleepTimeSlider.swift
//  SwiftUIBedTimeSlider
//
//  Created by ricardo silva on 26/04/2022.
//

import SwiftUI

struct SleepTimeSlider: View {
    
    @Binding var startAngle: Double
    @Binding var toAngle: Double
    
    @State var startProgress: CGFloat = 0
    @State var toProgress: CGFloat = 0.5
    
    var body: some View {
        
        GeometryReader { proxy in
            let width = proxy.size.width
            
            ZStack {
                
                ZStack {
                    ForEach(1...60,id: \.self) { index in
                        Rectangle()
                            .fill(index % 5 == 0 ? .black : .gray)
                            .frame(width: 2, height: index % 5 == 0 ? 10 : 5)
                            .offset(y: (width - 60) / 2)
                            .rotationEffect(.init(degrees: Double(index*6)))
                    }
                    
                    let texts = [6,9,12,3]
                    ForEach(texts.indices, id: \.self) { index in
                        Text("\(texts[index])")
                            .font(.caption.bold())
                            .foregroundColor(.black)
                            .rotationEffect(.init(degrees: Double(index) * -90))
                            .offset(y: (width - 90) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 90))
                        
                    }
                }
                
                Circle()
                    .stroke(.black.opacity(0.06), lineWidth: 40)
                
                let reverseRotation = (startProgress > toProgress) ? -Double(1 - startProgress) * 360 : 0
                
                Circle()
                    .trim(from: startProgress > toProgress ? 0 : startProgress, to: toProgress + (-reverseRotation / 360))
                    .stroke(.blue, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .foregroundColor(.blue)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .background(.white, in: Circle())
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                drag(value: value, fromSlider: true)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                Image(systemName: "alarm")
                    .font(.callout)
                    .foregroundColor(.blue)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -toAngle))
                    .background(.white, in: Circle())
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: toAngle))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                drag(value: value)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                VStack(spacing: 6) {
                    Text("\(TimeFunctions().getTimeDifference(startAngle: startAngle, toAngle: toAngle).0)hr")
                        .font(.largeTitle.bold())
                    Text("\(TimeFunctions().getTimeDifference(startAngle: startAngle, toAngle: toAngle).1)min")
                        .foregroundColor(.gray)
                    
                }
                .scaleEffect(1.1)
            }
        }
        .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.6)
    }
    
    func drag(value: DragGesture.Value, fromSlider: Bool = false) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        
        var angle = radians * 180 / .pi
        
        if angle < 0  { angle = 360 + angle }
        
        let progress = angle / 360
        
        if fromSlider {
            
            self.startAngle = angle
            self.startProgress = progress
            
        } else {
            self.toAngle = angle
            self.toProgress = progress
        }
        
    }
}

struct SleepTimeSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        SleepTimeSlider(startAngle: .constant(90), toAngle: .constant(180))
    }
}


