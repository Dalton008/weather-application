//
//  CurrentWeather.swift
//  weather-application
//
//  Created by Magic Jammie on 10/29/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import Foundation

struct CurrentWeather {
	
	let cityName: String
	
	let currentTemp: Double
	var currentTempString: String {
		return String(format: "%.0f", currentTemp)
	}
	
	let currentFeelsLike: Double
	var currentFeelsLikeString: String {
		return String(format: "%.0f", currentFeelsLike)
	}
	
	let id: Int
	
	init(currentWeatherData: CurrentWeatherData) {
		cityName = currentWeatherData.name
		currentTemp = currentWeatherData.main.temp
		currentFeelsLike = currentWeatherData.main.feelsLike
		id = currentWeatherData.weather.first!.id
	}
}
