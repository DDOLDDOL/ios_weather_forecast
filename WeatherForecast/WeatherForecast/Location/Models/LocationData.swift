//
//  Location.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/06.
//

import Foundation

struct LocationData {
    let nx: String // 행정구역코드 x좌표
    let ny: String // 행정구역코드 y좌표
    let address: String // 행정동명
    
    init(nx: String, ny: String, address: String) {
        self.nx = nx
        self.ny = ny
        self.address = address
    }
}
