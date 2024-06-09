////
////  AppReducer.swift
////  WeatherForecast
////
////  Created by MAC GNC on 2024/06/07.
////
//
import Foundation
import ReSwift

// AppAction과 AppState를 매핑하는 Reducer
func appRecuder(_ action: Action, _ state: AppState?) -> AppState {
    guard let _  = action as? AppAction else { return state ?? AppState() }
    
    switch (action as! AppAction) {
        case .emitWeatherLoading, .emitWeatherLoaded, .emitWeatherError:
            return _weatherReducer(action: action as! AppAction, previousState: state)
            
        case .emitLocationLoading, .emitLocationLoaded, .emitLocationError:
            return _locationReducer(action: action as! AppAction, previousState: state)
    }
}

// 날씨 관련 처리 전담 Reducer
fileprivate func _weatherReducer(action: AppAction, previousState: AppState?) -> AppState {
    switch action {
        case .emitWeatherLoading:
            let newState = previousState ?? AppState()
            newState.weatherState = .loading
            return newState
        
        case .emitWeatherLoaded(let weather):
            let newState = previousState ?? AppState()
            newState.weatherState = .loaded(weather: weather)
            return newState
        
        case .emitWeatherError(let message):
            let newState = previousState ?? AppState()
            newState.weatherState = .error(message: message)
            return newState
        
        default:
            return previousState ?? AppState()
    }
}

// 행정동 상태 처리 전담 Reducer
fileprivate func _locationReducer(action: AppAction, previousState: AppState?) -> AppState {
    switch action {
        case .emitLocationLoading:
            var newState = previousState ?? AppState()
            newState.locationState = .loading
            return newState
            
        case .emitLocationLoaded(let location):
            var newState = previousState ?? AppState()
            newState.locationState = .loaded(location: location)
            return newState
            
        case .emitLocationError(let message):
            var newState = previousState ?? AppState()
            newState.locationState = .error(message: message)
            return newState

        default:
            return previousState ?? AppState()
    }
}

