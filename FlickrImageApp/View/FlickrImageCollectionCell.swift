//
//  FlickrImageCollectionCell.swift
//  FlickrImageApp
//
//  Created by sonam taya on 2/3/22.
//

import UIKit

class FlickrImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageFlickr: UIImageView!

    var photoData : Photo! {
        didSet {
            guard let url =  photoData.getImageURL(farm: "\(photoData.farm ?? 0)", server: photoData.server ?? "", id: photoData.id ?? "", secret: photoData.secret ?? "") else { return }
           // print("URL:\(url)")
            UIImage.loadFrom(url: url) { image in
                if (image != nil) {
                    self.imageFlickr.image = image
                } else {
                    self.imageFlickr.image = UIImage(named: "NoData")

                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
