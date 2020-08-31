//
//  MyCIFilter.swift
//  bwThresholdTest
//
//  Created by shinichi teshirogi on 2020/08/28.
//  Copyright © 2020 paraches lifestyle lab. All rights reserved.
//

//
//  code from WWDC20 Build Metal-based Core Image kernels with Xcode
//

import Foundation
import CoreImage

class MyCIFilter: CIFilter {
    var inputImage: CIImage?
    var threshold = 0.0
    
    static var kernel: CIColorKernel = { () -> CIColorKernel in
        let url = Bundle.main.url(forResource: "MyKernel", withExtension: "ci.metallib")!
        let data = try! Data(contentsOf: url)
        return try! CIColorKernel(functionName: "thresholdFilter", fromMetalLibraryData: data)
    }()

    override var outputImage: CIImage? {
        get {
            guard let input = inputImage else { return nil }
            return MyCIFilter.kernel.apply(extent: input.extent, arguments: [input, threshold])
        }
    }
}
