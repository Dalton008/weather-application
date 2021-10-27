//
//  ViewController.swift
//  weather
//
//  Created by Magic Jammie on 10/26/21.
//  Copyright © 2021 Magic Jammie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private var myController: MyController?

	let mainLabel = UILabel()
	let searchCityButton = UIButton()
	var alert = UIAlertController()

	init(controller: MyController) {
		super.init(nibName: nil, bundle: nil)
		self.myController = controller
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		view.setupConstraints(label: mainLabel, topAnchor: view.topAnchor, botAnchor: nil, leftAnchor: view.leadingAnchor, rightAnchor: view.trailingAnchor, topConst: 100, botConst: nil, leadingConst: 16, trailingConst: -16, heightConst: 400, widthConst: nil)
		mainLabel.backgroundColor = .gray
		view.setupConstraints(label: searchCityButton, topAnchor: mainLabel.topAnchor, botAnchor: nil, leftAnchor: mainLabel.leadingAnchor, rightAnchor: mainLabel.trailingAnchor, topConst: 20, botConst: nil, leadingConst: 20, trailingConst: -20, heightConst: 30, widthConst: nil)
		
		searchCityButton.backgroundColor = .green
		searchCityButton.setTitle("Search city", for: .normal)
		searchCityButton.addTarget(self, action: #selector(searchCityButtonTap), for: .touchUpInside)
	}

	@objc private func searchCityButtonTap() {
		alert = UIAlertController(title: "Введите город:", message: nil, preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "Введите город"
		}
		
		let okButton = UIAlertAction(title: "Ok", style: .default) { action  in
			guard let cityName = self.alert.textFields?.first?.text else { return }
			let city = cityName.split(separator: " ").joined(separator: "%20")
			self.myController?.setCity(city: city)
		}
		let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		
		alert.addAction(okButton)
		alert.addAction(cancelButton)
	
		present(alert, animated: true, completion: nil)
	}
}
