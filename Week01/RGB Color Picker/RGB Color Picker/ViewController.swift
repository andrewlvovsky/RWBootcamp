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
        
        //let reverseColor = UIColor.init(displayP3Red: abs(redColor - 255), green: abs(greenColor - 255), blue: abs(blueColor - 255), alpha: 1.0)
    
        // Changes label colors dynamically based on background color so that labels aren't hard to see
        redColor < 0.5 && greenColor < 0.5 && blueColor < 0.5 ? changeTextColor(value: 1) : changeTextColor(value: 0)
        

        let alert = UIAlertController(title: "Color", message: "Choose a name for your color.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.colorNameLabel.text = alert.textFields![0].text!
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
    }
    
    func changeTextColor(value: CGFloat) {
        redLabel.textColor = UIColor.init(displayP3Red: value, green: value, blue: value, alpha: 1)
        greenLabel.textColor = UIColor.init(displayP3Red: value, green: value, blue: value, alpha: 1)
        blueLabel.textColor = UIColor.init(displayP3Red: value, green: value, blue: value, alpha: 1)
        redValueLabel.textColor = UIColor.init(displayP3Red: value, green: value, blue: value, alpha: 1)
        greenValueLabel.textColor = UIColor.init(displayP3Red: value, green: value, blue: value, alpha: 1)
        blueValueLabel.textColor = UIColor.init(displayP3Red: value, green: value, blue: value, alpha: 1)
        colorNameLabel.textColor = UIColor.init(displayP3Red: value, green: value, blue: value, alpha: 1)
    }

}

