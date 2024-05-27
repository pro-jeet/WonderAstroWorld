//
//  AstroCardView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

struct AstroCardView: View {
    
    @State var astro: Astro?
    @State var uiImage: UIImage?
    @State var error: String?
    @State var reload = false
    
    var body: some View {
        VStack {
            
            
            if let astro = astro {
                VStack {
                    Text(astro.title ?? "Title")
                        .tint(.black)
                    Text(astro.date ?? "Date")
                        .tint(.black)

                }
                .padding()
                
                Text(reload ? "" : "")
                
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
                            .frame(height: 400)
                    }
                }
                
                Spacer()
                
            }
        }
        .onAppear {
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
}
