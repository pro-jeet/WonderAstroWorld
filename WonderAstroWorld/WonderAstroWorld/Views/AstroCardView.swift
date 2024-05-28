//
//  AstroCardView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

/**
 A SwiftUI view representing a card displaying astronomical data.

 This view displays information about an astronomical object, such as its title and date, along with an image representing the object. It also handles the loading of the image asynchronously.

 ## Properties:
 - `astro`: An optional instance of `Astro` representing the astronomical object.
 - `uiImage`: A state variable representing the loaded image.
 - `error`: A state variable representing any error occurred during image loading.
 - `reload`: A state variable to trigger reloading of the view.

 ## Constants:
 - Various constants used for UI styling and layout.

 ## Methods:
 - `loadData()`: Asynchronously loads the image data from the provided URL.

 This view utilizes SwiftUI components such as `Text`, `ProgressView`, and `Image` to display the astronomical data and the associated image. It also includes logic to handle errors during image loading and to trigger the reloading of the view.
*/

struct AstroCardView: View {
    
    // Properties
    var astro: Astro?
    @State private var uiImage: UIImage?
    @State private var error: String?
    @State private var reload = false
    @State var urlString: String? = nil
    
    // Constants
    private let titlePlaceholder = "Title"
    private let datePlaceholder = "Date"
    private let emptyString = ""
    private let loadedWebViewStaticText = "Loaded in WebView"
    private let imageHeight: CGFloat = 400
    
    var body: some View {
        
        // Constants
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
                        
                        
                        if urlString != nil {
                            Text(loadedWebViewStaticText)
                                .font(.caption)
                                .tint(.pink)
                            
                            WebView(url: urlString!)

                        } else {
                            Text(error)
                                .font(.title)
                                .tint(.pink)
                        }
                        
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
    
    // Methods
    private func loadData() {
        // Data loading logic

        if let astro = astro {
            if let urlString = astro.url, let key = astro.date {
                DispatchQueue.global().async {
                    AstroCardViewModel().getData(urlString: urlString, key: key) { data, error   in
                        DispatchQueue.main.async {
                            if error == nil {
                                self.uiImage = data
                                self.error = nil
                            } else {
                                self.error = error
                                self.urlString = urlString
                            }
                            self.reload.toggle()
                        }
                    }
                }
            }
        }
    }
}
