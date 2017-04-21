//
//  ViewController2.swift
//  CustomTransitionsSwift2
//
//  Created by Ildar Zalyalov on 08.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dissmissedPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func setImage(selectedImage: UIImage){
        let bounds = UIScreen.main.bounds
        imageView.frame = CGRect(x: 5, y: Int(bounds.size.height/5), width: Int(bounds.size.width-10), height: Int(bounds.size.height*0.6))
        imageView.image = selectedImage
    }


}
