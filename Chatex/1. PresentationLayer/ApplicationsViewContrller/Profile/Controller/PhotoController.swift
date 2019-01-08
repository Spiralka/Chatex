//
//  PhotoController.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 25/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import UIKit



protocol CanReceive {
    func dataReceived(data: UIImage)
}

class PhotoController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var avatarImage: UIImage?
    
    var delegate: CanReceive?
    
    let manager = PhotoNetwork()
    var photoUrls: [InsideItems] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.getPhoto { (photoURL) in
                self.photoUrls = photoURL
            async {
                self.collectionView.reloadData()
            }
        }
        
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    

    let numberOfCellsPerRow: CGFloat = 3
    
    func settingCell() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)

}

    }
}


extension PhotoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        settingCell()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCell
        guard let urlOfPhoto = self.photoUrls[indexPath.row].webformatURL else { return UICollectionViewCell()}
        cell?.imageOfCell.downloaded(from: urlOfPhoto)
        return cell ?? UICollectionViewCell()
    }
 
}

extension PhotoController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell
        avatarImage = cell?.imageOfCell.image
        delegate?.dataReceived(data: avatarImage ?? UIImage())
        self.dismiss(animated: true)
    }
    
}



