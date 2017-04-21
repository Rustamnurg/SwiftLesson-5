//
//  ViewController.swift
//  CustomTransitionsSwift2
//
//  Created by Ildar Zalyalov on 08.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

protocol HandSelectedImages {
    func selectedImage(image: UIImage, imagePosition: ViewPosition, tag: Int)
}


struct ViewPosition {
    var height = 0
    var widht = 0
    var xPosition = 0
    var yPosition = 0    
}
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewPosition = ViewPosition()
    let cellIdentifier = "Cell"
    var selectedImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
}

extension ViewController: HandSelectedImages {
    internal func selectedImage(image: UIImage, imagePosition: ViewPosition, tag: Int) {
        let rectOfCellInTableView = tableView.rectForRow(at: IndexPath.init(row: tag, section: 0))
        let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
        viewPosition = imagePosition
        viewPosition.yPosition = Int(rectOfCellInSuperview.origin.y)
        selectedImage = image
        let toVC = self.storyboard?.instantiateViewController(withIdentifier: "toVC") as! ViewController2
        toVC.transitioningDelegate = self
        self.present(toVC, animated: true, completion: nil)
        toVC.setImage(selectedImage: image)
    }
    
    
}


extension ViewController: UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentController(withDuration: 0.7, presentedImage: selectedImage!, viewPosition: viewPosition)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissController(withDuration: 1.0, presentedImage: selectedImage!, viewPosition: viewPosition)
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! Cell
        cell.selectionStyle = .none
        cell.handSelectedImagesDelegate = self
        cell.firstImage.image = UIImage(named: "image")
        cell.secondImage.image = UIImage(named: "image1")
        cell.tag = indexPath.row
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rectOfCellInTableView = tableView.rectForRow(at: indexPath)
        let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
        viewPosition = ViewPosition.init(height: Int(rectOfCellInSuperview.height), widht: Int(rectOfCellInSuperview.width), xPosition: Int(rectOfCellInSuperview.origin.x), yPosition: Int(rectOfCellInSuperview.origin.y))
    }
    
}


