//
//  ViewController.swift
//  Scatter and Gather
//
//  Created by Linh Bouniol on 8/29/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

//extension UIView {
//    func fadeIn() {
//        UIView.animate(withDuration: 0.3,
//                       delay: 0.0,
//                       options: .curveEaseIn,
//                       animations: { self.alpha = 1.0 },
//                       completion: nil)
//    }
//
//    func fadeOut() {
//        UIView.animate(withDuration: 0.3,
//                       delay: 0.0,
//                       options: .curveEaseOut,
//                       animations: { self.alpha = 0.0 },
//                       completion: nil)
//    }
//}

class ViewController: UIViewController {
    
    var labelsArray: [UILabel] = []
    var imageView: UIImageView? = nil
    
    var shouldScramble: Bool = false
    
    @IBAction func toggle(_ sender: Any) {
        shouldScramble = !shouldScramble
        
        guard let imageView = imageView else { return }
        
        if shouldScramble {
//            imageView.fadeOut()
            
            UIView.animate(withDuration: 3, delay: 0.0, options: .curveEaseInOut, animations: {
                
//                imageView.alpha = 0.0
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(3.0)
                let animation = CAKeyframeAnimation(keyPath: "opacity")
                animation.values = [1.0, 0.25, 0.75, 0.0]
                imageView.layer.add(animation, forKey: "opacityAnimation")
                
                CATransaction.setCompletionBlock {
                    imageView.layer.opacity = 0.0
                }
                CATransaction.commit()
                
                guard let navigationHeight = self.navigationController?.navigationBar.frame.height else { return }
                
                for label in self.labelsArray {
                    label.frame.origin = CGPoint(x: CGFloat(drand48()) * (self.view.bounds.width - label.frame.width), y: CGFloat(drand48()) * (self.view.bounds.height - label.frame.height - navigationHeight) + navigationHeight)
                    
                    label.layer.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1.0, brightness: 1.0, alpha: 0.2).cgColor
                    
                    // Animation is weird!
//                    UIView.transition(with: label, duration: 3, options: .transitionCrossDissolve, animations: {
//                        label.textColor = UIColor(hue: CGFloat(drand48()), saturation: 1.0, brightness: 0.6, alpha: 1.0)
//                    }, completion: nil)
                    
                    label.textColor = UIColor(hue: CGFloat(drand48()), saturation: 1.0, brightness: 0.6, alpha: 1.0)
//                    label.transform = CGAffineTransform(rotationAngle: CGFloat(drand48()) * CGFloat.pi * 2)
                    
                    // Change any of the x, y, z values for different rotation (-1 to 1)
                    label.layer.transform = CATransform3DMakeRotation(CGFloat(drand48()) * CGFloat.pi * 2, 1.0, 1.0, 0.0)
                    
                    label.layer.shadowOpacity = 1.0
                    label.layer.shadowRadius = 5.0
                    
                }
            }, completion: nil)

        } else { // not scramble
            UIView.animate(withDuration: 3, delay: 0.0, options: .curveEaseInOut, animations: {
                
                imageView.alpha = 1.0
                
                // At the point, the view is already on the screen so we can ask the view how big it is.
                var xOffset = (self.view.bounds.width - (CGFloat(self.labelsArray.count) * 50.0)) / 2
                
                for label in self.labelsArray {
//                    label.transform = .identity
                    label.layer.transform = CATransform3DIdentity
                    
                    label.frame.origin = CGPoint(x: xOffset, y: 300.0)
                    xOffset += 50.0
                    label.layer.backgroundColor = UIColor.clear.cgColor    // layer properties are animated
                    label.textColor = UIColor.darkText
                    
//                    CATransaction.begin()
//                    CATransaction.setAnimationDuration(3.0)
//                    CATransaction.setDisableActions(false)
                    
                    label.layer.shadowOpacity = 0.0
                    label.layer.shadowRadius = 0.0
                    
//                    CATransaction.commit()
                }
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
        let string = "Lambda"
        
        // At this point, the viewController's view is created but not placed on the screen yet, so we don't know how big the view is to center the letters in it. So we ask the screen how big it is instead.
        let screenWidth = UIScreen.main.bounds.width
        
        var xOffset = (screenWidth - (CGFloat(string.count) * 50.0)) / 2
        
        for character in string {
            let label = UILabel(frame: CGRect(x: xOffset, y: 300.0, width: 50.0, height: 50.0))
            xOffset += 50.0
            label.font = UIFont.boldSystemFont(ofSize: 30.0)
            label.textAlignment = .center
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.text = String(character)
            
            labelsArray.append(label)
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
        
        // This imageView is the var outside this function
        self.imageView = imageView
        
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
