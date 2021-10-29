//
//  ViewController.swift
//  weather-application
//
//  Created by Magic Jammie on 10/29/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
	
	private var apiManager = APIManagerImpl()
	
	private var myView = MyView()

	var alert = UIAlertController()
	
	lazy var locationManager: CLLocationManager = {
		let lm = CLLocationManager()
		lm.delegate = self
		lm.desiredAccuracy = kCLLocationAccuracyKilometer
		lm.requestWhenInUseAuthorization()
		return lm
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		myView.delegate = self
		addMyView()

		apiManager.onComplition = { currentWeather in
			self.myView.updateInterface(weather: currentWeather)
		}
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.requestLocation()
		}
	}
	
	private func addMyView() {
		self.view.setupConstraints(label: myView, topAnchor: view.topAnchor, botAnchor: view.bottomAnchor, leftAnchor: view.leadingAnchor, rightAnchor: view.trailingAnchor, topConst: 0, botConst: 0, leadingConst: 0, trailingConst: 0, heightConst: nil, widthConst: nil)
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

extension ViewController: SearchCityDelegate {
	
	func buttonDidTap() {
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
}
