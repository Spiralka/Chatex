//
//  UIImageView+Ext.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 25/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit

class MagicImage: UIImageView {
    
    private var currenTask: URLSessionDataTask!
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        currenTask?.cancel()
        contentMode = mode
        currenTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            async {
                self.image = image
            }
        }
        currenTask?.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    
    func cancelTask() {
        currenTask?.cancel()
    }
}
