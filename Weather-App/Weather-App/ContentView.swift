//
//  ContentView.swift
//  Weather-App
//
//  Created by Tharsikan Sathasivam on 2025-11-24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var gradientColors: [Color] {
            [
                isNight ? Color.black : Color.blue,
                isNight ? Color.gray : Color("LightBlue")
            ]
        }
    
    
    var body: some View {
        
        ZStack {
            BackgroundView(colors: gradientColors)

            VStack{
                CityTextView(cityName: "jaffna")
                
                MainWeatherView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                
                
                HStack(spacing: 10){
                    WeatherDayView(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 88)
                    WeatherDayView(dayOfWeek: "THU", imageName: "wind.snow", temperature: 55)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "sun.dust.fill", temperature: 60)
                    WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temperature: 70)
                    WeatherDayView(dayOfWeek: "SUN", imageName: "sun.max.fill", temperature: 90)
                }
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton (btnName: "Change Day Time", textColor: .blue, bgColor: .white)

                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack (spacing: 15) {
            Text(dayOfWeek)
                .font(.system(size: 14, weight: .semibold, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text("\(temperature)°")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.white)
        }
    }
}


struct BackgroundView: View {
    var colors: [Color]
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}



struct CityTextView: View {
    var cityName: String

    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}


struct MainWeatherView: View {
    
    var imageName : String
    var temperature : Int
    
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}


struct WeatherButton: View {
    
    var btnName : String
    var textColor : Color
    var bgColor : Color
    
    var body: some View {
        Text( btnName)
            .frame(width: 280, height: 50)
            .background( bgColor)
            .foregroundColor( textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(12)
            .padding(.bottom, 40)
    }
}
