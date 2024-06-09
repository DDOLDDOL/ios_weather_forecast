//
//  Enums.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/03.
//

import Foundation

enum WeatherType: String {
    case PTY = "강수형태"
    case REH = "습도"
    case RN1 = "1시간 강수량"
    case T1H = "기온"
}

// 강우 패턴: PTY 카테고리의 코드
enum RainfallPattern: String {
    case none = "맑음" // 0
    case rain = "비" // 1, 5(빗방울)
    case rainAndSnow = "비/눈" // 2
    case snow = "눈" // 3, 7(눈날림)
    case shower = "소나기" // 4 (초단기 예보는 해당사항 없음
    case sleet = "진눈꺠비" // 6
}

// 강우/강설량: mm
enum Precipitation: Int {
    case none = 0
    case weak = 1
    case medium = 30
    case strong = 50
}

