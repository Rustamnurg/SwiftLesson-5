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
    // let customPresentController =
    let customDismissController = CustomDismissController()
    var viewPosition = ViewPosition()
    let cellIdentifier = "Cell"
    var selectedImageView: UIImageView?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        
    }
    
    
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "segue"{
    //            let toVC = segue.destination as! ViewController2
    //            customPresentController.viewPosition = viewPosition
    //            toVC.transitioningDelegate = self
    //        }
    //    }
    
}

extension ViewController: HandSelectedImages {
    internal func selectedImage(image: UIImage, imagePosition: ViewPosition, tag: Int) {
        var imagePosition2 = imagePosition
        selectedImageView?.image = image
        let cell = tableView(self.tableView, cellForRowAt: IndexPath.init(row: tag, section: 0))
        imagePosition2.yPosition = imagePosition.height + Int(cell.frame.origin.y)
        print(imagePosition2)
        
        self.performSegue(withIdentifier: "segue", sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "VC2")
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
}


extension ViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentController(withDuration: 2.0, presentedImageView: selectedImageView!)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissController
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
        cell.firstImage.image = UIImage.init(named: "image")
        cell.secondImage.image = UIImage.init(named: "image1")
        cell.tag = indexPath.row
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rectOfCellInTableView = tableView.rectForRow(at: indexPath)
        let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
        
        viewPosition = ViewPosition.init(height: Int(rectOfCellInSuperview.height), widht: Int(rectOfCellInSuperview.width), xPosition: Int(rectOfCellInSuperview.origin.x), yPosition: Int(rectOfCellInSuperview.origin.y))
        
        print(viewPosition)
        
        
        
        
        
        
    }
    
}


