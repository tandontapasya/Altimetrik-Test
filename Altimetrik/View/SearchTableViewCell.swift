//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell,NibLoadableView,ReusableView {

    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionPrice: UILabel!

    @IBOutlet weak var albumImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImage.image = nil
    }
    
    var albumListCellViewModel : AlbumListCellViewModel? {
        didSet {
            artistName.text = albumListCellViewModel?.artistName
            trackName.text = albumListCellViewModel?.trackName
            releaseDate.text = albumListCellViewModel?.releaseDate.description
            collectionPrice.text = albumListCellViewModel?.collectionPrice
            collectionName.text = albumListCellViewModel?.collectionName
            albumImage.loadThumbnail(urlSting: albumListCellViewModel?.artworkUrl ?? "")
        }
    }
}
