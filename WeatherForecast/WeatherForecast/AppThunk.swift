//
//  AppThunk.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/09.
//

import Foundation
import ReSwift
import ReSwiftThunk

// 비동기 상태 관리를 위한 썽크 (Reswift Thunk)

func fetchWeatherThunk(nx: String, ny: String) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, getState in
        dispatch(AppAction.emitWeatherLoading)
        
        WeatherRepository().fetchWeatherData(nx: nx, ny: ny) { weather in
            if let _ = weather {
                dispatch(AppAction.emitWeatherLoaded(weather!))
            } else {
                dispatch(AppAction.emitWeatherError("Weather Forecase Error"))
            }
        }
    }
}

func fetchLocationThunk(lat: Double, lng: Double) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, getState in
        dispatch(AppAction.emitLocationLoading)
        
        LocationRepository().getMyLocationByLatLng(lat: lat, lng: lng) { location in
            dispatch(AppAction.emitLocationLoaded(location))
            dispatch(fetchWeatherThunk(nx: location.nx, ny: location.ny))
            // TODO: error handling - throw & emit error
        }
    }
}
