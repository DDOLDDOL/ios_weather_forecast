//
//  AppState.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/07.
//

import Foundation

// 앱 전반 상태
class AppState {
    var locationState = LocationState.initial // weather initial state
    var weatherState = WeatherState.initial // location initial state
}

// 날씨 상태 Enumeration
enum WeatherState {
    case initial
    case loading
    case loaded(weather: WeatherData)
    case error(message: String)
}

// 행정동 상태 Enumeration
enum LocationState {
    case initial
    case loading
    case loaded(location: LocationData)
    case error(message: String)
}
