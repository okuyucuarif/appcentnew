//
//  UIImageView+DownloadImageExtension.swift
//  AppCentNew
//
//  Created by ArifOk on 9.06.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(with urlString : String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) {[weak self] result in
            switch result {
                case .success(let value):
                    self?.image = value.image
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
}
