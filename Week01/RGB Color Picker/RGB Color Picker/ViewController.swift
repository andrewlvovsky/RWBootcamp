//
//  ViewController.swift
//  RGB Color Picker
//
//  Created by Andrew Lvovsky on 5/28/20.
//  Copyright © 2020 Andrew Lvovsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redSlider : UISlider!
    @IBOutlet weak var greenSlider : UISlider!
    @IBOutlet weak var blueSlider : UISlider!
    
    @IBOutlet weak var redLabel : UILabel!
    @IBOutlet weak var greenLabel : UILabel!
    @IBOutlet weak var blueLabel : UILabel!
    @IBOutlet weak var redValueLabel : UILabel!
    @IBOutlet weak var greenValueLabel : UILabel!
    @IBOutlet weak var blueValueLabel : UILabel!
    @IBOutlet weak var colorNameLabel : UILabel!
    
    @IBOutlet weak var setColorButton : UIButton!
    @IBOutlet weak var resetButton : UIButton!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetColor()
    }
    
    @IBAction func updateRedLabel() {
        let redLabelText = String(Int(redSlider.value.rounded()))
        redValueLabel.text = redLabelText
    }
    
    @IBAction func updateGreenLabel() {
        let greenLabelText = String(Int(greenSlider.value.rounded()))
        greenValueLabel.text = greenLabelText
    }
    
    @IBAction func updateBlueLabel() {
        let blueLabelText = String(Int(blueSlider.value.rounded()))
        blueValueLabel.text = blueLabelText
    }

    @IBAction func updateColor() {
        let redColor = CGFloat(redSlider.value.rounded()) / 255
        let greenColor = CGFloat(greenSlider.value.rounded())/255
        let blueColor = CGFloat(blueSlider.value.rounded()) / 255
        
        let reverseColor = UIColor.init(displayP3Red: abs(redColor - 1), green: abs(greenColor - 1), blue: abs(blueColor - 1), alpha: 1.0)
        
        if ((redColor > 0.4 && redColor < 0.6) && (greenColor > 0.4 && greenColor < 0.6) && (blueColor > 0.4 && blueColor < 0.6)) {
            // If color is gray-ish, just set label color to white to avoid gray-on-gray color
            changeLabelColor(newColor: UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 1))   // basic white color
        } else {
            // Changes label colors dynamically based on background color so that labels aren't hard to see
            changeLabelColor(newColor: reverseColor)
        }

        let alert = UIAlertController(title: "Color", message: "Choose a name for your color.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            if (alert.textFields![0].text != "") {
                self.colorNameLabel.text = alert.textFields![0].text!
            } else {
                self.colorNameLabel.text = "No Color Name Specified"
            }
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        self.view.backgroundColor = UIColor.init(displayP3Red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        
    }
    
    @IBAction func resetColor() {
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0

        redValueLabel.text = "0"
        greenValueLabel.text = "0"
        blueValueLabel.text = "0"
        self.colorNameLabel.text = "Black"
        
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0)
        changeLabelColor(newColor: UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 1.0))
    }
    
    func changeLabelColor(newColor: UIColor) {
        redLabel.textColor = newColor
        greenLabel.textColor = newColor
        blueLabel.textColor = newColor
        redValueLabel.textColor = newColor
        greenValueLabel.textColor = newColor
        blueValueLabel.textColor = newColor
        colorNameLabel.textColor = newColor
        
        setColorButton.tintColor = newColor
        resetButton.tintColor = newColor
    }

}

