//
//  GestureDelegate.swift
//  GestureSample
//
//  Created by atif on 29/03/18.
//  Copyright © 2018 Zemoso. All rights reserved.
//

import UIKit

protocol GestureCallbackProtocol {
    func gestureEventStarted(view : UIView, gestureRecognizer : UIGestureRecognizer) -> Void
    func handleTap(view : UIView) -> Void
    func handleLongPress(view : UIView) -> Void
    func handleSwipe(view : UIView) -> Void
    func handlePan(view : UIView, dX : CGFloat, dY : CGFloat) -> Void
    func handlePinch(view : UIView, scale : CGFloat) -> Void
    func handleRotate(view : UIView, changeInAngle angle : CGFloat) -> Void
    func gestureEventEnded(view : UIView, gestureRecognizer : UIGestureRecognizer) -> Void
}
