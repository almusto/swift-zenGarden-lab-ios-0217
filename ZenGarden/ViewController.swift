//
//  ViewController.swift
//  ZenGarden
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var rock: UIImageView!
  @IBOutlet weak var rake: UIImageView!
  @IBOutlet weak var sword: UIImageView!
  @IBOutlet weak var shrub: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
      rock.isUserInteractionEnabled = true
      shrub.isUserInteractionEnabled = true
      rake.isUserInteractionEnabled = true
      sword.isUserInteractionEnabled = true

      rock.translatesAutoresizingMaskIntoConstraints = false
      rock.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPan(_:))))

      shrub.translatesAutoresizingMaskIntoConstraints = false
      shrub.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPan(_:))))

      rake.translatesAutoresizingMaskIntoConstraints = false
      rake.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPan(_:))))

      sword.translatesAutoresizingMaskIntoConstraints = false
      sword.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPan(_:))))

    }

  func checkWin() {

    let viewWidth = view.frame.size.width
    let viewHeight = view.frame.size.height

    let shrubCenter = shrub.center.y
    let rakeCenter = rake.center.y


    if ((sword.center.x < 100 && sword.center.y < 100) || (sword.center.x > viewWidth - 150  && sword.center.y > viewHeight - 150)) && (abs(rakeCenter - shrubCenter) < 100)  {
      if ((sword.center.x < 100 && sword.center.y < 100) && rock.center.y > viewHeight/2) || ((sword.center.x > viewWidth - 150  && sword.center.y > viewHeight - 150) && rock.center.y < viewHeight/2) {
        presentAlert()
          }

  }
  }

  func onPan(_ pan: UIPanGestureRecognizer) {
    let translation = pan.translation(in: self.view)
    pan.view!.center = CGPoint(x: pan.view!.center.x + translation.x, y: pan.view!.center.y + translation.y)
    pan.setTranslation(CGPoint.zero, in: self.view)
    checkWin()

  }

  func presentAlert() {

    let viewArray = [rake, sword, shrub, rock]


    let alertController = UIAlertController(title: "You Won!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
    let alertAction = UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
        for view in viewArray {
          let randomX = Int(arc4random_uniform(UInt32(self.view.frame.size.width)))
          let randomY = Int(arc4random_uniform(UInt32(self.view.frame.size.height)))
          view?.center = CGPoint(x: randomX, y: randomY)
        }
      })

    alertController.addAction(alertAction)

    self.present(alertController, animated: true, completion: nil)
  }




}

