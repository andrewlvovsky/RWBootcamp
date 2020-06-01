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
    @IBOutlet weak var infoButton : UIButton!
    
    @IBOutlet weak var segController : UISegmentedControl!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetColor()    // sets color to black (0,0,0) on start
    }
    
    // The three following action funcs update the value of the respective slider and display it
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

    // falls in when "Set Color" is hit
    @IBAction func updateColor() {
        let redColor, greenColor, blueColor : CGFloat
        if (segController.selectedSegmentIndex == 0) {  // RGB
            redColor = CGFloat(redSlider.value.rounded()) / 255
            greenColor = CGFloat(greenSlider.value.rounded()) / 255
            blueColor = CGFloat(blueSlider.value.rounded()) / 255
        } else {    // HSB
            redColor = CGFloat(redSlider.value.rounded()) / 360
            greenColor = CGFloat(greenSlider.value.rounded()) / 100
            blueColor = CGFloat(blueSlider.value.rounded()) / 100
        }
        
        // this color is the "opposite" of the selected color so labels don't blend into the color
        let reverseColor = UIColor.init(displayP3Red: abs(redColor - 1), green: abs(greenColor - 1), blue: abs(blueColor - 1), alpha: 1.0)
        
        if ((redColor > 0.4 && redColor < 0.6) && (greenColor > 0.4 && greenColor < 0.6) && (blueColor > 0.4 && blueColor < 0.6)) {
            // If color is gray-ish, just set label color to white to avoid gray-on-gray color
            changeLabelColor(newColor: UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 1))   // basic white color
        } else {
            // Changes label colors dynamically based on background color so that labels aren't as hard to see
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
        
        // Sets color based on color mode
        if (segController.selectedSegmentIndex == 0) {
            self.view.backgroundColor = UIColor.init(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        } else {
            self.view.backgroundColor = UIColor.init(hue: redColor, saturation: greenColor, brightness: blueColor, alpha: 1.0)
        }
        
    }
    
    // resets color to black when called (called on start and when "Reset" button is pressed)
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
    
    // helper function for changing color of labels
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
        infoButton.tintColor = newColor
        
        segController.backgroundColor = newColor
    }
    
    // func called by segmented control to determine color mode
    @IBAction func modeChanged(_ sender: Any) {
        if (segController.selectedSegmentIndex == 0) {
            changeToRGB()
        } else if (segController.selectedSegmentIndex == 1){
            changeToHSB()
        } else {
            print("Error: Out-of-bounds index on segment controller")
        }
    }
    
    // helper function for setting RGB environment
    func changeToRGB() {
        redLabel.text = "Red"
        greenLabel.text = "Green"
        blueLabel.text = "Blue"
        redSlider.maximumValue = 255
        greenSlider.maximumValue = 255
        blueSlider.maximumValue = 255
        
        resetColor()
    }

    // helper function for setting HSB environment
    func changeToHSB() {
        redLabel.text = "Hue"
        greenLabel.text = "Saturation"
        blueLabel.text = "Brightness"
        redSlider.maximumValue = 360
        greenSlider.maximumValue = 100
        blueSlider.maximumValue = 100
        
        resetColor()
    }
}

