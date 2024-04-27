//
//  CollectionViewCells.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/27/24.
//

import Foundation
import UIKit
import Kingfisher

class ChartCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
//    override var isSelected: Bool {
//        didSet {
//            titleLabel?.textColor = isSelected ? .black : UIColor.black.withAlphaComponent(0.7)
//            titleLabel?.font = isSelected ? .body2Bold : .body2Medium
//            selectionView?.isHidden = !isSelected
//        }
//    }
}

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView! {
        didSet {
            titleImageView.layer.cornerRadius = 8
        }
    }
    
    func configureImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        titleImageView.kf.setImage(with: url, completionHandler: { [weak self] result in
            switch result {
            case .success(let value):
                let image = value.image
                let insets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: image.size.width - 2)
                let resizableImage = image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
                
                DispatchQueue.main.async {
                    self?.titleImageView.image = resizableImage
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImagView: UIImageView! {
        didSet {
            thumbnailImagView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var playTimeLabel: UILabel! {
        didSet {
            playTimeLabel.layer.cornerRadius = 3
            playTimeLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        thumbnailImagView.kf.setImage(with: url)
    }
}

class SecondVideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.delegate = self
            videoCollectionView.dataSource = self
        }
    }
    var videoData: [VideoItem] = [] {
        didSet {
            videoCollectionView.reloadData()
        }
    }
}


class CollectionViewHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
}

extension SecondVideoCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallVideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else {
            fatalError("Unexpected collection view")
        }
        let item = videoData[indexPath.row]
        cell.loadImage(with: item.thumnailImageURL)
        cell.playTimeLabel.text = item.playTime
        cell.titleLabel.text = item.title
        cell.artistLabel.text = item.artist

        return cell
    }
}

extension SecondVideoCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width * 0.7, height: collectionView.bounds.size.height)
    }
}
