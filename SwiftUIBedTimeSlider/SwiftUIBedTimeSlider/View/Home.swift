//
//  Home.swift
//  SwiftUIBedTimeSlider
//
//  Created by ricardo silva on 26/04/2022.
//

import SwiftUI

struct Home: View {
    
    @State var startAngle: Double = 0
    @State var toAngle: Double = 180
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today")
                        .font(.title.bold())
                    
                    Text("Good Morning! Ricardo")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    
                } label: {
                    
                    Image("perfilImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }

            }
            
            SleepTimeSlider(startAngle: $startAngle, toAngle: $toAngle)
                .padding(.top, 50)
            
            Button {
                
            } label: {
                Text("Start Sleep")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 40)
                    .background(.blue, in: Capsule())
                
            }
            .padding(.top, 45)
            
            HStack(spacing: 25) {
                VStack(alignment: .leading, spacing: 8) {
                    Label {
                        Text("BedTime")
                            .foregroundColor(.black)
                    } icon: {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.blue)
                    }
                    .font(.callout)
                    
                    Text(TimeFunctions().getTime(angle:startAngle).formatted(date: .omitted, time: .shortened))
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading, spacing: 8) {
                    Label {
                        Text("Wakeup")
                            .foregroundColor(.black)
                    } icon: {
                        Image(systemName: "alarm")
                            .foregroundColor(.blue)
                    }
                    .font(.callout)
                    
                    Text(TimeFunctions().getTime(angle:toAngle).formatted(date: .omitted, time: .shortened))
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .background(.black.opacity(0.06), in: RoundedRectangle(cornerRadius: 15))
            .padding(.top, 35)

        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
    

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
