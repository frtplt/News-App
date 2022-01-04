//
//  TableViewCell.swift
//  News App
//
//  Created by Firat on 2.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    static let identifier = "TableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    func configure(with model: Article){
        self.descriptionLabel.text = model.description
        self.titleLabel.text = model.title
        let url = model.urlToImage
        if let data = try? Data(contentsOf: URL(string: url)!){
            self.newsImage.image = UIImage(data: data)
        }
        
    }
    
}
