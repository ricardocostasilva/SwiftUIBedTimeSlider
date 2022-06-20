//
//  TimeFunctions.swift
//  SwiftUIBedTimeSlider
//
//  Created by ricardo silva on 26/04/2022.
//

import Foundation

struct TimeFunctions {
    
    func getTime(angle: Double) -> Date {
        
        let progress = angle / 30
        
        let hour = Int(progress)
        
        let remainder = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()
        
        var minute = remainder * 5
        
        minute = (minute > 55 ? 55 : minute)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        if let date = formatter.date(from: "\(hour): \(Int(minute)):00") {
            return date
        }
        
        return .init()
        
    }
    
    func getTimeDifference(startAngle: Double, toAngle: Double) -> (Int, Int) {
        let calendar = Calendar.current
        
        let result = calendar.dateComponents([.hour, .minute], from: getTime(angle: startAngle), to: getTime(angle: toAngle))
        
        return (result.hour ?? 0, result.minute ?? 0)
    }
}
