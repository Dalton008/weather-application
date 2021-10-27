//
//  APIManager.swift
//  weather
//
//  Created by Magic Jammie on 10/26/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import Foundation

struct APIManager {
	
	func getCurrentWeather(forCity: String) {
		
		let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(forCity)&appid=485da49d6847dab6181280b0d0a6cbed"
		guard let url = URL(string: urlString) else { return }
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: url) { data, response, error in
			if let data = data {
				self.parseJSON(data: data)
			}
		}
		task.resume()
	}
	
	func parseJSON(data: Data) -> CurrentWeather? {
		let decoder = JSONDecoder()
		
		do {
			let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
//			print(currentWeatherData.main.temp)
			guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
			print(currentWeather.cityName)
			print(currentWeather.currentTempString)
			return currentWeather
		} catch let error as NSError {
			print(error.localizedDescription)
		}
		return nil
	}
}
