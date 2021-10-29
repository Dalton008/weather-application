//
//  APIManager.swift
//  weather
//
//  Created by Magic Jammie on 10/26/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import Foundation
import CoreLocation

final class APIManagerImpl: APIManager {

	var onComplition: ((CurrentWeather) -> Void)?
	
	func getCurrentWeather(forRequestType: RequestType) {
		var urlString = ""
		
		switch forRequestType {
		case .cityName(let city):
			urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=485da49d6847dab6181280b0d0a6cbed&units=metric"
		case .coordinate(let latitude, let longitude):
			urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=485da49d6847dab6181280b0d0a6cbed&units=metric"
		}
		perforfmRequest(withURL: urlString)
	}
	
	private func perforfmRequest(withURL: String) {
		guard let url = URL(string: withURL) else { return }
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: url) { data, response, error in
			if let data = data {
				if let currentWeather = self.parseJSON(data: data) {
					self.onComplition?(currentWeather)
				}
			}
		}
		task.resume()
	}

	private func parseJSON(data: Data) -> CurrentWeather? {
		let decoder = JSONDecoder()
		
		do {
			let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
			let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData)
			return currentWeather
		} catch let error as NSError {
			print(error.localizedDescription)
		}
		return nil
	}
}
