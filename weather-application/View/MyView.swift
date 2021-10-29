//
//  MyView.swift
//  weather-application
//
//  Created by Magic Jammie on 10/29/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import UIKit

class MyView: UIView {
	
	var delegate: SearchCityDelegate?
	
	private let mainLabel = UILabel()
	private let searchCityButton = UIButton()
	private var tempLabel = UILabel()
	private var feelsLikeLabel = UILabel()
	private var cityLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		createMainLabel()
		createSearchCityButton()
		createTempLabel()
		createFeelsLikeLabel()
		createCityLabel()
	}
	
	private func createMainLabel() {
		self.setupConstraints(label: mainLabel, topAnchor: self.topAnchor, botAnchor: nil, leftAnchor: self.leadingAnchor, rightAnchor: self.trailingAnchor, topConst: 100, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 400, widthConst: nil)
	}
	
	private func createSearchCityButton() {
		self.setupConstraints(label: searchCityButton, topAnchor: mainLabel.topAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 20, trailingConst: -20, heightConst: 40, widthConst: nil)
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

	func updateInterface(weather: CurrentWeather) {
		DispatchQueue.main.async {
			self.cityLabel.text = weather.cityName
			self.tempLabel.text = weather.currentTempString
			self.feelsLikeLabel.text = weather.currentFeelsLikeString
		}
	}
	
	@objc private func searchCityButtonTap() {
		delegate?.buttonDidTap()
	}
}

