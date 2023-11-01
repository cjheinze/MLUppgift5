//
//  ContentView.swift
//  MLUppgift5
//
//  Created by Carl-Johan Heinze on 2023-10-31.
//

import SwiftUI

struct ContentView: View {
    
    @State var image1 = ImageClassification(image: .dandelion)
    @State var image2 = ImageClassification(image: .carnation)

    var body: some View {
        VStack {
            HStack {
                viewForClassification(image1)
                viewForClassification(image2)
            }
        }
        .padding()
    }
    
    func viewForClassification(_ imageClassification: ImageClassification) -> some View {
        VStack {
            Image(uiImage: imageClassification.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button("Analysera") {
                imageClassification.classifyImage()
            }
            .buttonStyle(.borderedProminent)
            if let label = imageClassification.classification {
                let labels = label.split(separator: ",").map(\.capitalized)
                ForEach(labels, id: \.self) { label in
                    Text(label)
                }
                
            }
            if let probability = imageClassification.probablity {
                Text(
                    probability,
                    format: .percent.precision(
                        .significantDigits(6)
                    )
                )
            }
        }
    }
}
#Preview {
    ContentView()
}
