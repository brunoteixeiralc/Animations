//
//  ViewController.swift
//  animations
//
//  Created by Bruno Lemgruber on 20/03/2018.
//  Copyright © 2018 Bruno Correa. All rights reserved.
//

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tip: UIView!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var tipPosition = CGPoint.zero
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loginBtn.center.y += 30
        loginBtn.alpha = 0.0
        
        username.center.x -= view.bounds.width
        pass.center.x -= view.bounds.width
        heading.center.x -= view.bounds.width
        
        tip.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animate(withDuration: 0.5) {
            self.heading.center.x += self.view.bounds.width
        
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseInOut], animations: {
            self.username.center.x += self.view.bounds.width
        
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [.curveEaseInOut], animations: {
            self.pass.center.x += self.view.bounds.width
        
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
            self.loginBtn.center.y -= 30
            self.loginBtn.alpha = 1.0
        
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 10.0, height: 10.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginBtn.addSubview(spinner)
        
    }
    
    @IBAction func login(){
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.spinner.center = CGPoint(x: 40.0, y: self.loginBtn.frame.size.height/2)
            self.spinner.alpha = 1.0
            self.loginBtn.setTitle("Carregando...", for: .normal)
            self.loginBtn.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            self.loginBtn.center.y += 50.0
            self.loginBtn.bounds.size.width = self.pass.bounds.size.width
            
        }, completion: {_ in
            self.showTip()
        })
    }
    
    func removeTip(){
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.tip.center.x += self.view.frame.size.width
        }) { (_) in
            self.tip.isHidden = true
            self.tip.center = self.tipPosition
            self.sucessLogin()
        }
    }
    
    func sucessLogin(){
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.loginBtn.center.y -= 50.0
            self.loginBtn.setTitle("Sucesso", for: .normal)
            self.loginBtn.backgroundColor = UIColor.brown
            self.spinner.alpha = 0.0
        }, completion: nil)
    }
    
    func showTip(){
        UIView.transition(with: tip, duration: 0.33, options: [.curveEaseOut,.transitionFlipFromTop], animations: {
            self.tip.isHidden = false
            
        }, completion: {_ in
            delay(2.0){
                self.removeTip()
            }
        })
    }
}

