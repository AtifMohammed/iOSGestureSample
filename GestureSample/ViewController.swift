//
//  ViewController.swift
//  GestureSample
//
//  Created by atif on 29/03/18.
//  Copyright © 2018 Zemoso. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GestureRecogniserDelegate {
    
    //MARK: View Controller

    var gestureRecogniser: GestureRecogniser?
    @IBOutlet weak var gestureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureRecogniser = GestureRecogniser()
        gestureRecogniser!.setTargetView(targetView: gestureImageView, gestureDelegate: self)
    }
    
    //MARK: Gesture Delegate
    
    func gestureEventStarted(view: UIView, gestureRecognizer: UIGestureRecognizer) {
        print("Gesture Event: Started")
    }
    
    func handleTap(view: UIView) {
        print("Gesture Event: Tap")
    }
    
    func handleLongPress(view: UIView) {
        print("Gesture Event: Long Press")
    }
    
    func handleSwipe(view: UIView) {
        print("Gesture Event: Swipe")
    }
    
    func handlePinch(view: UIView, scale: CGFloat) {
        print("Gesture Event: Pinch, scale = \(scale)")
        view.transform = view.transform.scaledBy(x: scale, y: scale)
    }
    
    func handlePan(view: UIView, dX: CGFloat, dY: CGFloat) {
        print("Gesture Event: Pan, dX = \(dX), dY = \(dY)")
        view.transform = view.transform.translatedBy(x: dX, y: dY)
    }
    
    func handleRotate(view: UIView, changeInAngle angle: CGFloat) {
        print("Gesture Event: Rotate, angle = \(angle)")
        view.transform = view.transform.rotated(by: angle)
    }
    
    func gestureEventEnded(view: UIView, gestureRecognizer: UIGestureRecognizer) {
        print("Gesture Event: Ended")
    }
    
}

