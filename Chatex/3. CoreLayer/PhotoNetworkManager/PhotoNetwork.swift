//
//  PhotoModel.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 25/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation


class PhotoNetwork {
    
    func getPhoto(handler: @escaping ([InsideItems]) -> Void) {
        guard let url = URL(string: "https://pixabay.com/api/?key=10798417-884f4d7ce8c64e03d7c2d954e&per_page=100") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard  let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(PhotoData.self, from: data)
                handler(decodedData.hits)
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
        
    }
    
    
    
}
