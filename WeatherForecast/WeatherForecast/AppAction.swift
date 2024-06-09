//
//  AppAction.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/07.
//

import Foundation
import ReSwift

// 앱 전반부 이벤트
enum AppAction: Action {
    case emitWeatherLoading
    case emitWeatherLoaded(_ weather: WeatherData)
    case emitWeatherError(_ message: String)
    case emitLocationLoading
    case emitLocationLoaded(_ location: LocationData)
    case emitLocationError(_ message: String)
}
