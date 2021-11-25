//
//  MyView.swift
//  weather-application
//
//  Created by Magic Jammie on 10/29/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import UIKit

class MyView: UIView {
	
	weak var delegate: SearchCityDelegate?
	
	private let mainLabel = UILabel()
	private lazy var searchCityButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 10
		button.setTitle("Search city", for: .normal)
		button.addTarget(self, action: #selector(searchCityButtonTap), for: .touchUpInside)
		return button
	}()
	private lazy var tempLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = .lightGray
		label.textAlignment = .center
		return label
	}()
	private lazy var feelsLikeLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = .lightGray
		label.textAlignment = .center
		return label
	}()
	private lazy var cityLabel: UILabel = {
		let lable = UILabel()
		lable.backgroundColor = .lightGray
		lable.textAlignment = .center
		return lable
	}()
	
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
	}

	private func createTempLabel() {
		mainLabel.setupConstraints(label: tempLabel, topAnchor: searchCityButton.bottomAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 50, widthConst: nil)
	}

	private func createFeelsLikeLabel() {
		mainLabel.setupConstraints(label: feelsLikeLabel, topAnchor: tempLabel.bottomAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 50, widthConst: nil)
	}

	private func createCityLabel() {
		mainLabel.setupConstraints(label: cityLabel, topAnchor: feelsLikeLabel.bottomAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 50, widthConst: nil)
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

