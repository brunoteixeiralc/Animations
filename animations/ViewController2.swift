//
//  ViewController2.swift
//  animations
//
//  Created by Bruno Lemgruber on 21/03/2018.
//  Copyright © 2018 Bruno Correa. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    
    var isMenuOpen:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isMenuOpen = false
    }
    
    @IBAction func actionToggleMenu(){
        
        isMenuOpen = !isMenuOpen
        
        menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
        
        headerTitle.text = isMenuOpen ? "Selecione os itens" : "Menu Principal"
        headerTitle.superview?.constraints.forEach({ (constraint) in
            if constraint.firstItem === headerTitle &&
                constraint.firstAttribute == .centerX{
                constraint.constant = isMenuOpen ? -100.0 : 0.0
                return
            }
            
            if constraint.identifier == "TitleCenterY" {
                constraint.isActive = false
                
                let newConstraint = NSLayoutConstraint(
                    item: headerTitle,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: headerTitle.superview!,
                    attribute: .centerY,
                    multiplier: isMenuOpen ? 0.37 : 1.0,
                    constant: 5.0)
                newConstraint.identifier = "TitleCenterY"
                newConstraint.isActive = true
                return
            }
        })
        
        let angle: CGFloat = isMenuOpen ? .pi/4 : 0.0
        btnMenu.transform = CGAffineTransform(rotationAngle: angle)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: [.curveEaseIn], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
