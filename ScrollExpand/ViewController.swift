//
//  ViewController.swift
//  ScrollExpand
//
//  Created by Siavash Abbasalipour on 10/10/16.
//  Copyright © 2016 sa. All rights reserved.
//

import UIKit
import pop

enum PanState {
    case open
    case close
}
class ViewController: UIViewController {

    var pane: DraggableView!
    let roundedViewHeight: CGFloat = 250
    var paneState: PanState = .close
    var animation: POPSpringAnimation!

    var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let size = view.bounds.size
        
        let draggableView = DraggableView(frame:CGRect(x: 0, y: size.height - 60, width: size.width, height: size.height))
        draggableView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        draggableView.delegate = self
        view.addSubview(draggableView)
        pane = draggableView
        let panRecogniser = UIPanGestureRecognizer(target: self, action: #selector(self.didPan(_:)))
        view.addGestureRecognizer(panRecogniser)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name(rawValue: Notification.Name.UIKeyboardWillShow.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name(rawValue: Notification.Name.UIKeyboardWillHide.rawValue), object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func targetPoint() -> CGPoint {
        let size = view.bounds.size
        //size.height = keyboardHeight > 0 ? size.height + keyboardHeight : size.height
        return paneState == .close ? CGPoint(x: size.width/2, y: size.height + 300) : CGPoint(x: size.width/2, y: size.height - 320/4.0 - (1.5*keyboardHeight))
    }
    
    func didPan(_ gesture: UIPanGestureRecognizer) {
        paneState = paneState == .open ? .close : .open
        let vel = animation.velocity as! CGPoint
        animatePaneWithInitialVelocity(vel)
    }
    
    func animatePaneWithInitialVelocity(_ initialVelocity: CGPoint) {
        pane.pop_removeAllAnimations()
        animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        animation.velocity = NSValue.init(cgPoint: initialVelocity)
        animation.toValue = NSValue.init(cgPoint: targetPoint())
        animation.springSpeed = 8
        animation.springBounciness = 2
        pane.pop_add(animation, forKey: "animation")
        
    }

}

extension ViewController: DraggableViewDelegate {
    func draggableViewBeganDragging(_ view: DraggableView) {
        view.layer.pop_removeAllAnimations()
    }
    
    func draggableView(_ view: DraggableView, draggingEndedWith velocity: CGPoint) {
        paneState = velocity.y >= 0 ? .close : .open
        if paneState == .close {
            view.endEditing(true)
        }
        animatePaneWithInitialVelocity(velocity)
    }
    
    func draggableViewSearchBarTapped(_ view: DraggableView) {
//        pane.pop_removeAllAnimations()
//        let size = view.bounds.size
//        animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
//        let initialVelocity = CGPoint(x: 0.0, y: -2117.54516385144)
//        animatePaneWithInitialVelocity(initialVelocity)
//        let targetPoint = CGPoint(x: size.width/2, y: size.height + 320 - 5)
//        animation.velocity = NSValue.init(cgPoint: initialVelocity)
//        animation.toValue = NSValue.init(cgPoint: targetPoint)
//        animation.springSpeed = 12
//        animation.springBounciness = 10
//        pane.pop_add(animation, forKey: "animation")
//         paneState = .open
    }
    func draggableViewSearchBarCancelled(_ view: DraggableView) {
//        pane.pop_removeAllAnimations()
//        let size = view.bounds.size
//        animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
//        let initialVelocity = CGPoint(x: 0.0, y: 2117.54516385144)
//        animatePaneWithInitialVelocity(initialVelocity)
//        let targetPoint = CGPoint(x: size.width/2, y: size.height - 320 + 5)
//        animation.velocity = NSValue.init(cgPoint: initialVelocity)
//        animation.toValue = NSValue.init(cgPoint: targetPoint)
//        animation.springSpeed = 12
//        animation.springBounciness = 10
//        pane.pop_add(animation, forKey: "animation")
//        paneState = .close
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let keyboardInfo = (notification as NSNotification).userInfo
        let keyboardFrameBegin = keyboardInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrameBeginRect = keyboardFrameBegin.cgRectValue
        keyboardHeight = keyboardFrameBeginRect.height
        let initialVelocity = CGPoint(x: 0.0, y: -2117.54516385144)
        paneState = .open
        animatePaneWithInitialVelocity(initialVelocity)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
        let initialVelocity = CGPoint(x: 0.0, y: 2117.54516385144)
        paneState = .close
        animatePaneWithInitialVelocity(initialVelocity)
    }
}
















