//
//  ViewController.swift
//  UnityLoaderDemo
//
//  Created by German on 5/21/18.
//  Copyright © 2018 Rootstrap Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var toggleButton: UIButton!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var colorButton: UIButton!
  @IBOutlet weak var animationIndicator: UILabel!
  
  var appDelegate: AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
  }
  var unityView: UIView {
    return UnityGetGLViewController().view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(unityAppAnimating), name: NSNotification.unityAppAnimateModel, object: nil)
  }
  
  @objc func unityAppAnimating(notification: Notification) {
    guard let info = notification.userInfo else { return }
    let active = info["active"] as? Bool ?? false
    toggleAnimating(active: active)
  }
  
  func toggleAnimating(active: Bool) {
    animationIndicator.text = active ? "YES" : "NO"
    animationIndicator.textColor = active ? #colorLiteral(red: 0.1568627451, green: 0.8941176471, blue: 0, alpha: 1) : #colorLiteral(red: 0.9058823529, green: 0.0862745098, blue: 0.1294117647, alpha: 1)
  }
  
  @IBAction func toggleUnityScene() {
    var active = appDelegate?.isUnityRunning == true
    if active {
      UnitySendMessage("Cube", "stopAnimating", "")
      toggleAnimating(active: false)
      unityView.removeFromSuperview()
      appDelegate?.stopUnity()
    } else {
      appDelegate?.startUnity()
      unityView.frame = containerView.bounds
      containerView.addSubview(unityView)
    }
    //Get latest status
    active = appDelegate?.isUnityRunning == true
    toggleButton.isSelected = active
    toggleButton.setTitle(active ? "Unload Scene": "Load Unity Scene", for: .normal)
    colorButton.isEnabled = active
  }
  
  @IBAction func changeColor() {
    let newTint = UIColor.random.hexString
    print("Will change color to: " + newTint)
    UnitySendMessage("Cube", "changeColor", newTint)
  }
}

extension UIColor {
  
  var hexString: String {
    guard let components = cgColor.components else { return "" }
    let r = components[0]
    let g = components[1]
    let b = components[2]
    
    return String(format: "#%02lX%02lX%02lX",
                  lroundf(Float(r) * 255),
                  lroundf(Float(g) * 255),
                  lroundf(Float(b) * 255))
  }
  
  static var random: UIColor {
    let r: CGFloat = CGFloat(arc4random_uniform(255)) / 255.0
    let g: CGFloat = CGFloat(arc4random_uniform(255)) / 255.0
    let b: CGFloat = CGFloat(arc4random_uniform(255)) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: 1)
  }
}

