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
    
    @IBOutlet weak var colorNameLabel : UILabel!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetColor()
    }
    
    @IBAction func updateRedLabel() {
        let redLabelText = String(Int(redSlider.value.rounded()))
        redLabel.text = redLabelText
    }
    
    @IBAction func updateGreenLabel() {
        let greenLabelText = String(Int(greenSlider.value.rounded()))
        greenLabel.text = greenLabelText
    }
    
    @IBAction func updateBlueLabel() {
        let blueLabelText = String(Int(blueSlider.value.rounded()))
        blueLabel.text = blueLabelText
    }

    @IBAction func updateColor() {
        //CGFloat = redSlider.value
        let redColor = CGFloat(redSlider.value.rounded()) / 255
        let greenColor = CGFloat(greenSlider.value.rounded())/255
        let blueColor = CGFloat(blueSlider.value.rounded()) / 255
        
        print("Red is \(redColor)")
        print("Green is \(greenColor)")
        print("Blue is \(blueColor)")

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
        
        redLabel.text = "0"
        greenLabel.text = "0"
        blueLabel.text = "0"
        
        self.colorNameLabel.text = "White"
    }
    

}

