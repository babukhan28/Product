//
//  UIImageView+Extension.swift
//  Product
//
//  Created by Rajni on 12/05/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
