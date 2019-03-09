//
//  ViewController.swift
//  DrawThis
//
//  Created by Vanessa Latefa Pampilo on 3/8/19.
//  Copyright © 2019 Vanessa Latefa Pampilo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var currentPosition : CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //you can decide with the events you chose
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        let touch = touches.first
        if let position = touch?.location(in: imageView){

            currentPosition = position
            addText(start: position)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let movedPosition = touch?.location(in: imageView){
           
            draw(start: currentPosition, stop: movedPosition)
            currentPosition = movedPosition
        }
        
    }
    
    func draw (start : CGPoint, stop : CGPoint){
        //1. begin graphic context
        UIGraphicsBeginImageContext(imageView.frame.size)
        
        //asking for the image we already have in the image view
        imageView.image?.draw(in: imageView.bounds)//draw the existing image into this context
        
        //because we guard it , the program will not crash of its nil. It will just return
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.move(to: start)
        context.addLine(to: stop)
        context.strokePath()
        
        //finally
        //draw the new drawing context back to the image view
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    func addText (start : CGPoint){
        //1. begin graphic context
        UIGraphicsBeginImageContext(imageView.frame.size)
        
        //asking for the image we already have in the image view
        //draw the existing image into this context
        
        let attributes : [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 50.0),
                .foregroundColor : UIColor.blue
        ]
        
        let string = NSAttributedString(string: "Hello", attributes : attributes)
        string.draw(at: start)
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }

}

extension UIImage{
    
    func resizeImage(newWidth : CGFloat) -> UIImage{
        
        let newHeight = newWidth * ( self.size.height / self.size.width )
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in : CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
       return newImage ?? UIImage()
    }
}

