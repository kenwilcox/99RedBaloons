//
//  ViewController.swift
//  99RedBalloons
//
//  Created by Kenneth Wilcox on 9/21/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var balloonLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var balloons: [Balloon] = []
  var images: [UIImage] = []
  var colors: [UIColor] = []
  
  var index:Int = 0
  var balloonIndex = 0
  var colorIndex = 0
  var currentIndex = -1
  
  //MARK: - UI handlers
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setupBaloonImages()
    setupColors()
    createBalloons()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func nextBallonPressed(sender: AnyObject) {
    let balloon = self.balloons[self.index]
    displayBalloon(balloon)
    
    if self.index < balloons.count - 1 {
      self.index++
    } else {
      self.index = 0
    }
  }
  
  func displayBalloon(balloon:Balloon) {
    UIView.transitionWithView(self.view, duration: 0.25, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
      self.imageView.image = balloon.image
      self.balloonLabel.text = "Balloon \(balloon.number)"
      self.balloonLabel.textColor = balloon.color
      self.balloonLabel.backgroundColor = self.backColorForColor(balloon.color)
      }, completion: { (finished: Bool) -> () in
    })
  }
  
  //MARK: - Helper Methods
  func setupColors() {
    colors.append(UIColor.redColor())
    colors.append(UIColor.whiteColor())
    colors.append(UIColor.blueColor())
  }
  
  func setupBaloonImages() {
    images.append(UIImage(named: "RedBalloon1.jpg")!)
    images.append(UIImage(named: "RedBalloon2.jpg")!)
    images.append(UIImage(named: "RedBalloon3.jpg")!)
    images.append(UIImage(named: "RedBalloon4.jpg")!)
  }
  
  func createBalloons() {
    for var i = 1; i < 100; i++ {
      var balloon = Balloon()
      balloon.number = i
      balloon.image = randomBalloon()
      balloon.color = nextColor()
      balloons.append(balloon)
    }
  }
  
  func randomBalloon() -> UIImage {
    var randomIndex: Int
    do {
      randomIndex = Int(arc4random_uniform(UInt32(images.count)))
    } while self.currentIndex == randomIndex
    self.currentIndex = randomIndex
    
    return images[randomIndex]
  }
  
  func nextBalloon() -> UIImage {
    var image = images[self.balloonIndex]
    
    if self.balloonIndex < images.count - 1 {
      self.balloonIndex++
    } else {
      self.balloonIndex = 0
    }
    
    return image
  }
  
  func nextColor() -> UIColor {
    var color = colors[self.colorIndex]
    if self.colorIndex < colors.count - 1 {
      self.colorIndex++
    } else {
      self.colorIndex = 0
    }
    return color
  }
  
  func backColorForColor(color: UIColor) -> UIColor {
    var ret = UIColor.blackColor()
    switch(color) {
    case UIColor.redColor(): ret = UIColor.whiteColor()
    case UIColor.whiteColor(): ret = UIColor.blueColor()
    case UIColor.blueColor(): ret = UIColor.whiteColor()
    default: ret = UIColor.blackColor()
    }
    return ret
  }
}

