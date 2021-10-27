//
//  ViewController.swift
//  weather
//
//  Created by Magic Jammie on 10/26/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
	
	private var apiManager = APIManager()

	let mainLabel = UILabel()
	let searchCityButton = UIButton()
	var alert = UIAlertController()
	var tempLabel = UILabel()
	var feelsLikeLabel = UILabel()
	var cityLabel = UILabel()
	
	lazy var locationManager: CLLocationManager = {
		let lm = CLLocationManager()
		lm.delegate = self
		lm.desiredAccuracy = kCLLocationAccuracyKilometer
		lm.requestWhenInUseAuthorization()
		return lm
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		createMainLabel()
		createSearchCityButton()
		createTempLabel()
		createFeelsLikeLabel()
		createCityLabel()
		
		apiManager.onComplition = { currentWeather in
			self.updateInterfaceWith(weather: currentWeather)
		}
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.requestLocation()
		}
	}

	private func createMainLabel() {
		view.setupConstraints(label: mainLabel, topAnchor: view.topAnchor, botAnchor: nil, leftAnchor: view.leadingAnchor, rightAnchor: view.trailingAnchor, topConst: 100, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 400, widthConst: nil)
	}
	
	private func createSearchCityButton() {
		view.setupConstraints(label: searchCityButton, topAnchor: mainLabel.topAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 20, trailingConst: -20, heightConst: 40, widthConst: nil)
		searchCityButton.backgroundColor = .systemBlue
		searchCityButton.layer.cornerRadius = 10
		searchCityButton.setTitle("Search city", for: .normal)
		searchCityButton.addTarget(self, action: #selector(searchCityButtonTap), for: .touchUpInside)
	}
	
	private func createTempLabel() {
		mainLabel.setupConstraints(label: tempLabel, topAnchor: searchCityButton.bottomAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 50, widthConst: nil)
		tempLabel.backgroundColor = .lightGray
		tempLabel.textAlignment = .center
	}
	
	private func createFeelsLikeLabel() {
		mainLabel.setupConstraints(label: feelsLikeLabel, topAnchor: tempLabel.bottomAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 50, widthConst: nil)
		feelsLikeLabel.backgroundColor = .lightGray
		feelsLikeLabel.textAlignment = .center
	}
	
	private func createCityLabel() {
		mainLabel.setupConstraints(label: cityLabel, topAnchor: feelsLikeLabel.bottomAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 50, widthConst: nil)
		cityLabel.backgroundColor = .lightGray
		cityLabel.textAlignment = .center
	}
	
	@objc private func searchCityButtonTap() {
		alert = UIAlertController(title: "Введите город:", message: nil, preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "Введите город"
		}
		
		let okButton = UIAlertAction(title: "Ok", style: .default) { action  in
			guard let cityName = self.alert.textFields?.first?.text else { return }
			let city = cityName.split(separator: " ").joined(separator: "%20")
			self.apiManager.getCurrentWeather(forRequestType: .cityName(city: city))
		}
		let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		alert.addAction(okButton)
		alert.addAction(cancelButton)
	
		present(alert, animated: true, completion: nil)
	}
	
	func updateInterfaceWith(weather: CurrentWeather) {
		DispatchQueue.main.async {
			self.cityLabel.text = weather.cityName
			self.tempLabel.text = weather.currentTempString
			self.feelsLikeLabel.text = weather.currentFeelsLikeString
		}
	}
}

extension ViewController: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		let lattitude = location.coordinate.latitude
		let longitude = location.coordinate.longitude
		
		apiManager.getCurrentWeather(forRequestType: .coordinate(latitide: lattitude, longitude: longitude))
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error.localizedDescription)
	}
}
