//
//  GestureRecogniserDelegate.swift
//  GestureSample
//
//  Created by atif on 29/03/18.
//  Copyright © 2018 Zemoso. All rights reserved.
//

import UIKit

protocol GestureRecogniserDelegate : GestureCallbackProtocol {
    
    //MARK: Gesture protocols
    
    func gestureEventStarted(view : UIView, gestureRecognizer : UIGestureRecognizer)
    
    func handleTap(view: UIView)
    
    func handleLongPress(view: UIView)
    
    func handleSwipe(view: UIView)
    
    func handlePinch(view: UIView, scale: CGFloat)
    
    func handlePan(view: UIView, dX: CGFloat, dY: CGFloat)
    
    func handleRotate(view: UIView, changeInAngle angle: CGFloat)
    
    func gestureEventEnded(view : UIView, gestureRecognizer : UIGestureRecognizer)
}
