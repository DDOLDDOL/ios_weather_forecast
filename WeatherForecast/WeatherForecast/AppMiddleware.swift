//
//  Middlewares.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/07.
//

import Foundation
import ReSwift
import ReSwiftThunk

let appMiddleware: Middleware<AppState> = createThunkMiddleware()
