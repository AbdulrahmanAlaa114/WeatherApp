//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: WeatherPresenterProtocol!
    let locationManager = LocationManager()
    var isFetching = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "7-Day Weather Forecast"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let forecastStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLocation()
    }
    
    func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(forecastStackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            forecastStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            forecastStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            forecastStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            forecastStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
        
    func setupLocation() {
        
        locationManager.locationUpdateHandler = { [weak self] location in
            self?.handleLocationUpdate(location)
        }
        
        locationManager.authorizationDenied = { [weak self]  in
            self?.showAlertForLocationPermission()
        }
        locationManager.requestLocationUpdate()
    }
        
    func populateData(weatherModel: WeatherModel) {
        if let forecast = weatherModel.forecast?.forecastday {
            for day in forecast {
                if let date = day.date, let avgTempC = day.day?.avgtempC {
                    let dateString = date.formatDate()
                    let weatherLabel = UILabel()
                    weatherLabel.text = "\(dateString): \(avgTempC)°C"
                    weatherLabel.textColor = .black
                    weatherLabel.textAlignment = .center
                    weatherLabel.font = UIFont.systemFont(ofSize: 18)
                    forecastStackView.addArrangedSubview(weatherLabel)
                }
            }
        }
    }
    
    func handleLocationUpdate(_ location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        if !isFetching {
            isFetching = true
            presenter.fetchWeatherData(withLang: longitude, andLat: latitude)
        }
    }
    
    func showAlertForLocationPermission() {
        let alert = UIAlertController(title: "Location Permission Required", message: "Please enable location access in settings to use this feature.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - WeatherViewProtocol

extension WeatherViewController: WeatherViewProtocol {
    
    func reloadData() {
        forecastStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let weatherModel = presenter.getWeatherData()
        populateData(weatherModel: weatherModel)
    }
    
    func showIndicator() {
        DispatchQueue.main.async {
            self.showSpinner()
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.hideSpinner()
        }
    }
}
