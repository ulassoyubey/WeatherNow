//
//  WeatherImageView.swift
//  WeatherNow
//
//  Created by ulas soyubey on 26.05.2022.
//

import UIKit
import Alamofire
import AlamofireImage

class WeatherImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds = true // sets the image to not have sharp corners in addition to the layer corner radius
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    func downloadImage(fromUrl imageUrl: String){
        //print(imageUrl)
        if let imageURL = URL(string: imageUrl), let placeholder = UIImage(named: "default") {
            self.af.setImage(withURL: imageURL, placeholderImage: placeholder)
        }
    }
}
