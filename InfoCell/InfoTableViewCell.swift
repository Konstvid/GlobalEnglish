//
//  InfoTableViewCell.swift
//  English
//
//  Created by Andrey on 08.09.2021.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet var imageInfo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageInfo.layer.cornerRadius = 30
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(info: Grammar)  {
        imageInfo.image = UIImage(named: info.imageGrammar)
    }
}
