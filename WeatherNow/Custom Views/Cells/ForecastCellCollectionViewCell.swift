//
//  ForecastCellCollectionViewCell.swift
//  WeatherNow
//
//  Created by ulas soyubey on 28.05.2022.
//

import UIKit

class ForecastCellCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "forecastReuseId"
    
    let imageView = WeatherImageView(frame: .zero)
    let time = WeatherNowTitleLabel(fontSize: 20, textAligment: .center)
    let celcius = WeatherNowSecondaryLabel(fontSize: 20, textAligment: .center)
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         configure()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    private func configure(){
        
        addSubview(time)
        addSubview(imageView)
        addSubview(celcius)
        
        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            time.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: time.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            celcius.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 2),
            celcius.centerXAnchor.constraint(equalTo: centerXAnchor),
            celcius.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
    
    func setCells(forecast:Hour){
        time.text = forecast.time.components(separatedBy: " ")[1]
        celcius.text = String(forecast.tempC) + "°C"
        imageView.downloadImage(fromUrl: "https://" +  String(forecast.condition.icon.dropFirst(2)))
    }
    
}
