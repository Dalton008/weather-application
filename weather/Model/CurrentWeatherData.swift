//
//  CurrentWeatherData.swift
//  weather
//
//  Created by Magic Jammie on 10/26/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import Foundation

struct CurrentWeatherData: Codable {
	let name: String
	let main: Main
	let weather: [WeatherElement]
}

struct Main: Codable {
	let temp: Double
	let feelsLike: Double
	
	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
	}
}

struct WeatherElement: Codable {
	let id: Int
}
