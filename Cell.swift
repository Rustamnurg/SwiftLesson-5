//
//  Cell.swift
//  CustomTransitionsSwift2
//
//  Created by Rustam N on 15.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    var handSelectedImagesDelegate: HandSelectedImages? = nil
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        firstImage.addGestureRecognizer(tapGestureRecognizer2)
        firstImage.isUserInteractionEnabled = true
        secondImage.addGestureRecognizer(tapGestureRecognizer)
        secondImage.isUserInteractionEnabled = true
        
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
     
        
        
        handSelectedImagesDelegate?.selectedImage(image: tappedImage.image!, imagePosition: ViewPosition(height: Int(tappedImage.frame.height), widht: Int(tappedImage.frame.width), xPosition: Int(tappedImage.frame.origin.x), yPosition: Int(tappedImage.frame.origin.y)), tag: self.tag)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
