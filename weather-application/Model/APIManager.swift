//
//  APIManager.swift
//  weather-application
//
//  Created by Magic Jammie on 10/29/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import Foundation
import CoreLocation

enum RequestType {
	case cityName(city: String)
	case coordinate(latitide: CLLocationDegrees, longitude: CLLocationDegrees)
}

protocol APIManager {
	func getCurrentWeather(forRequestType: RequestType)
}
