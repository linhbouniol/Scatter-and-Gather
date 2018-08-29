//
//  ViewController.swift
//  Scatter and Gather
//
//  Created by Linh Bouniol on 8/29/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var shouldScramble: Bool = false
    
    @IBAction func toggle(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
        let string = "Lambda"
        var xOffset = 75.0
        
        for character in string {
            let label = UILabel(frame: CGRect(x: xOffset, y: 300.0, width: 50.0, height: 50.0))
            xOffset += 50.0
            label.font = UIFont.boldSystemFont(ofSize: 30.0)
            label.text = String(character)
            view.addSubview(label)
        }
        
        // This will size the image for you. Here, the image is too large, so we want to size the image ourself.
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "Lambda_Logo_Full"))
//        imageView.frame.origin = CGPoint(x: 100.0, y: 300.0)
        
        // Assign the image to constant and use the .size property to calculate the height. Width can be anything we want, but the height will be scaled to that.
        let image = #imageLiteral(resourceName: "lambda logo")
    
//        let imageView = UIImageView(frame: CGRect(x: 100.0, y: 300.0, width: 250.0, height: 250.0 * image.size.height / image.size.width))
        
        // We want to horizontally center the imageView, so constrains is a proper way to do this. But to do this we need to not pass in any frame for the imageView and use constrains to do that.
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        view.addSubview(imageView)
        
        let imageWidthConstraint = NSLayoutConstraint(item: imageView,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 100.0)
        
        let imageHeightConstraint = NSLayoutConstraint(item: imageView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: imageView,
                                                      attribute: .width,
                                                      multiplier: image.size.height/image.size.width,
                                                      constant: 0.0)
        
        let imageCenterXConstraint = NSLayoutConstraint(item: imageView,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0.0)
        
        let imageTopConstraint = NSLayoutConstraint(item: imageView,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: 150.0)
        
        NSLayoutConstraint.activate([imageWidthConstraint, imageHeightConstraint, imageCenterXConstraint, imageTopConstraint])
    }
}

