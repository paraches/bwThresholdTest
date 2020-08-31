//
//  ViewController.swift
//  bwThresholdTest
//
//  Created by shinichi teshirogi on 2020/08/28.
//  Copyright © 2020 paraches lifestyle lab. All rights reserved.
//

import UIKit
import Metal

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    let bwThresholdFilter = MyCIFilter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let image = UIImage(named: "sample0") else { return }
        self.imageView.image = image
        bwThresholdFilter.inputImage = CIImage(image: image)
        
        doOCR(threshold: Double(slider!.value))
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            sliderValueLabel.text = "\(slider.value)"
            doOCR(threshold: Double(slider.value))
        }
    }
    
    private func doOCR(threshold: Double) {
        bwThresholdFilter.threshold = threshold
        
        if let output = bwThresholdFilter.outputImage {
            let bwUIImage = UIImage(ciImage: output)
            self.imageView2.image = bwUIImage
        }
    }
}

