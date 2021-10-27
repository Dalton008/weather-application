//
//  Controller.swift
//  weather
//
//  Created by Magic Jammie on 10/26/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import Foundation

class MyController {
	
	let apiManager = APIManager()
	
	func setCity(city: String) {
		apiManager.getCurrentWeather(forCity: city)
	}
}
