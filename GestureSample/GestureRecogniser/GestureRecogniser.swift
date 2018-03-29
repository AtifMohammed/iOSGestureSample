//
//  GestureRecogniser.swift
//  GestureSample
//
//  Created by atif on 29/03/18.
//  Copyright © 2018 Zemoso. All rights reserved.
//

import UIKit

class GestureRecogniser: NSObject, UIGestureRecognizerDelegate {

    //MARK: Variables
    
    private var targetView : UIView? = nil
    private var gestureDelegate : GestureRecogniserDelegate? = nil
    private var previousDelta : CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    //MARK: Setters
    
    public func setTargetView(targetView view : UIView, gestureDelegate : GestureRecogniserDelegate){
        
        //Initializing the gesture listeners
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(sender:)))
        let swipeGestureRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(sender:)))
        let pinchGestureRecogniser = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch(sender:)))
        let panGestureRecogniser = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(sender:)))
        let rotateGestureRecogniser = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotate(sender:)))
        
        tapGestureRecogniser.delegate = self
        longPressGestureRecogniser.delegate = self
        swipeGestureRecogniser.delegate = self
        pinchGestureRecogniser.delegate = self
        panGestureRecogniser.delegate = self
        rotateGestureRecogniser.delegate = self
    
        //setting the gesture listeners
        view.addGestureRecognizer(tapGestureRecogniser)
        view.addGestureRecognizer(longPressGestureRecogniser)
        view.addGestureRecognizer(swipeGestureRecogniser)
        view.addGestureRecognizer(pinchGestureRecogniser)
        view.addGestureRecognizer(panGestureRecogniser)
        view.addGestureRecognizer(rotateGestureRecogniser)
        view.isUserInteractionEnabled = true
        self.targetView = view
        self.gestureDelegate = gestureDelegate
        print("Listeners Initialized")
    }
    
    //MARK: Gesture Recogniser Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //disabling for different views
        if(gestureRecognizer.view != otherGestureRecognizer.view){
            return false
        }
        
        //disabling for tap
        if(gestureRecognizer is UITapGestureRecognizer || otherGestureRecognizer is UITapGestureRecognizer){
            return false
        }
        
        //disabling for long press
        if(gestureRecognizer is UILongPressGestureRecognizer || otherGestureRecognizer is UILongPressGestureRecognizer){
            return false
        }
        
        return true
    }
    
    //MARK: Public Gesture Recognizer
    
    @objc public func handleTap(sender: UITapGestureRecognizer) {
        gestureDelegate!.handleTap(view: targetView!)
    }
    
    @objc public func handleLongPress(sender: UILongPressGestureRecognizer) {
        if(sender.state == .began){
            gestureDelegate!.handleLongPress(view: targetView!)
        }else{
            print("No Action for Long Press")
        }
    }
    
    @objc public func handleSwipe(sender: UIGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            if(swipeGesture.state == .began){
                gestureDelegate!.handleSwipe(view: targetView!)
            }else{
                print("No Action for Swipe")
            }
        }
    }
    
    @objc public func handlePinch(sender : UIGestureRecognizer) {
        if let pinchGesture = sender as? UIPinchGestureRecognizer{
            switch sender.state {
            case .began:
                gestureDelegate!.gestureEventStarted(view: targetView!, gestureRecognizer: sender)
                break
            case .changed:
                gestureDelegate!.handlePinch(view: targetView!, scale: pinchGesture.scale)
                pinchGesture.scale = 1.0
                break
            case .ended:
                gestureDelegate!.gestureEventEnded(view: targetView!, gestureRecognizer: sender)
                break
            default:
                print("No Action for Pinch")
            }
        }else{
            print("Pinch called but failed")
        }
    }
    
    @objc public func handlePan(sender: UIGestureRecognizer) {
        if let panGesture = sender as? UIPanGestureRecognizer{
            switch sender.state {
            case .began:
                gestureDelegate!.gestureEventStarted(view: targetView!, gestureRecognizer: sender)
                previousDelta = CGPoint(x: 0.0, y: 0.0)
                break
            case .changed:
                let radians : CGFloat = CGFloat(atan2f(Float(targetView!.transform.b), Float(targetView!.transform.a)));
                let translation = panGesture.translation(in: targetView!.superview)
                let X = (translation.x-previousDelta.x)
                let Y = (translation.y-previousDelta.y)
                let deltaX = X * cos(radians) + Y * sin(radians)
                let deltaY = Y * cos(radians) - X * sin(radians)
                let scale = targetView!.transform.a
                gestureDelegate!.handlePan(view: targetView!, dX: deltaX / scale, dY: deltaY / scale)
                previousDelta = translation
                break
            case .ended:
                gestureDelegate!.gestureEventEnded(view: targetView!, gestureRecognizer: sender)
                break
            default:
                print("No Action for Pan")
            }
        }else{
            print("Pan called but failed")
        }
    }
    
    @objc public func handleRotate(sender: UIGestureRecognizer) {
        if let rotateGesture = sender as? UIRotationGestureRecognizer{
            switch sender.state {
            case .began:
                gestureDelegate!.gestureEventStarted(view: targetView!, gestureRecognizer: sender)
                break
            case .changed:
                gestureDelegate!.handleRotate(view: targetView!, changeInAngle: rotateGesture.rotation)
                rotateGesture.rotation = 0
                break
            case .ended:
                gestureDelegate!.gestureEventEnded(view: targetView!, gestureRecognizer: sender)
                break
            default:
                print("No Action for Rotate")
            }
        }else{
            print("Rotate called but failed")
        }
    }
}
