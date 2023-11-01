//
//  ImageClassification.swift
//  MLUppgift4
//
//  Created by Carl-Johan Heinze on 2023-10-18.
//

import Vision
import UIKit

@Observable class ImageClassification: Identifiable {
    let image: UIImage
    var classification: String? = nil
    var probablity: Double? = nil
    
    init(image: UIImage) {
        self.image = image
    }
    
    func classifyImage() {
        let defaultConfig = MLModelConfiguration()
        
        let imageClassifierWrapper = try? FlowerClassifier(configuration: defaultConfig)
        
        guard let imageClassifier = imageClassifierWrapper else {
            return
        }
        
        guard let cgImage = image.cgImage else {
            return
        }

        do {
            let output = try imageClassifier.prediction(input: FlowerClassifierInput(imageWith: cgImage))
            print(output)
            classification = output.target
            probablity = output.targetProbability[output.target]
        } catch {
            classification = "Unknown Flower"
        }
    }
}
