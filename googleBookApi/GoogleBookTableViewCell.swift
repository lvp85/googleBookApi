//
//  GoogleBookTableViewCell.swift
//  googleBookApi
//
//  Created by Udagedara Dehigama on 2021/12/29.
//

import UIKit

class GoogleBookTableViewCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Discription: UILabel!
    
    @IBOutlet weak var GoggleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func OnBind(data:Items){
        Title.text = data.volumeInfo.title
        print(data.volumeInfo.title)
        Discription.text = data.volumeInfo.description
         
        let url = data.volumeInfo.imageLinks.thumbnail
        print(url)
        if let data = try? Data(contentsOf: URL(string: url)!){
           self.GoggleImage.image = UIImage(data: data)
       }
    
    }
}
