//
//  AstroCardView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

struct AstroCardView: View {
    
    var astro: Astro?
    @State private var uiImage: UIImage?
    @State private var error: String?
    @State private var reload = false
    
    private let titlePlaceholder = "Title"
    private let datePlaceholder = "Date"
    private let emptyString = ""
    private let imageHeight: CGFloat = 400
    
    var body: some View {
        VStack {
            
            
            if let astro = astro {
                VStack {
                    Text(astro.title ?? titlePlaceholder)
                        .tint(.black)
                    Text(astro.date ?? datePlaceholder)
                        .tint(.black)

                }
                .padding()
                
                Text(reload ? emptyString : emptyString)
                
                if uiImage == nil {
                    if let error = error {
                        Text(error)
                            .font(.title)
                            .tint(.red)
                    } else {
                        ProgressView()
                    }
                } else {
                    if let uiImage = uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(height: imageHeight)
                    }
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        if let astro = astro {
            if let urlString = astro.url, let key = astro.date {
                DispatchQueue.global().async {
                    AstroCardViewModel().getData(urlString: urlString, key: key) { data, error   in
                        DispatchQueue.main.async {
                            if error == nil {
                                self.uiImage = data
                            } else {
                                self.error = nil
                            }
                            self.reload.toggle()
                        }
                    }
                }
            }
        }
    }
}
