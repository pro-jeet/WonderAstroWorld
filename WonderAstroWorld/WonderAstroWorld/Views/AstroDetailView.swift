//
//  AstroDetailView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

/**
 A SwiftUI view representing a detailed view of astronomical data.

 This view displays detailed information about an astronomical object, such as its title, date, explanation, and an image representing the object. It also provides options to load high-definition (HD) images and view the image in full screen.

 ## Properties:
 - `astro`: An optional instance of `Astro` representing the astronomical object.
 - `image`: A state variable representing the loaded image.
 - `loadHD`: A state variable to toggle loading of high-definition images.
 - `expanded`: A state variable to control the expansion of the explanation text.
 - `showProgressView`: A state variable to control the visibility of the progress view.
 - `error`: A state variable representing any error occurred during image loading.
 - `reload`: A state variable to trigger reloading of the view.
 - Various constants used for UI styling and layout.

 ## Methods:
 - `loadData(astro:)`: Asynchronously loads the image data from the provided URL based on the selected options.

 This view utilizes SwiftUI components such as `Text`, `ProgressView`, `Image`, and `ScrollView` to display detailed information about the astronomical object and the associated image. It includes options to toggle loading of HD images, expand the explanation text, and view the image in full screen. Additionally, it handles the asynchronous loading of image data and error handling.
*/

struct AstroDetailView: View {
    
    // Properties
    var astro: Astro?
    @State private var image: UIImage?
    
    @State private var loadHD = false
    @State private var expanded = false
    @State private var showProgressView = false
    @State private var error: String?
    @State private var reload = false
    @State private var showImageOnFullScreen = false
    
    // Constants
    private let titlePlaceholder = "Title"
    private let normalButtonTitle = "Normal"
    private let hdButtonTitle = "HD"
    private let datePlaceholder = "Date"
    private let explanationPlaceholder = "Explanation"
    private let readMoreButtonTitle = "Read More"
    private let readLessButtonTitle = "Read Less"
    private let emptyString = ""
    private let inExpandedLineLimit = 5
    private let buttonFontSize: CGFloat = 15
    private let ScreenSize = UIScreen.main.bounds
    private let wAWCornerRadius: CGFloat = 10
    private let paddingProgressView = UIScreen.main.bounds.width/CGFloat(2)
    
    // View body
    var body: some View {
        
        // View hierarchy
        if showImageOnFullScreen {
            if let image = image {
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollView(.vertical, showsIndicators: false) {
                        FullScreenImageView(uiImage: image)
                            .onTapGesture {
                                showImageOnFullScreen = false
                            }
                    }
                }
            } else {
            }
        } else {
            
            Text(astro?.title ?? titlePlaceholder)
                .font(.headline)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            loadHD.toggle()
                            showProgressView = true
                            if let astro = astro {
                                loadData(astro: astro)
                            }
                        }, label: {
                            Text(loadHD ? normalButtonTitle : hdButtonTitle)
                        })
                        
                    }
                    
                }
            
            Text(astro?.date ?? datePlaceholder)
                .font(.footnote)
                .bold()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    
                    if let astro = astro {
                        VStack {
                            HStack {
                                Text(astro.explanation ?? explanationPlaceholder)
                                    .lineLimit(expanded ? .max : inExpandedLineLimit)
                            }
                            .padding()
                            
                            Button(expanded ? readLessButtonTitle : readMoreButtonTitle ) {
                                expanded.toggle()
                            }
                            .font(.system(size: buttonFontSize, weight: .semibold))
                        }
                        
                        VStack (alignment: .center) {
                            
                            Text(loadHD ? emptyString : emptyString)
                            
                            if showProgressView {
                                ProgressView()
                                    .controlSize(.extraLarge)
                                    .padding(.leading, paddingProgressView)
                            } else {
                                
                                if image == nil {
                                    if let error = error {
                                        Text(error)
                                            .font(.title)
                                            .tint(.red)
                                    } else {
                                        ProgressView()
                                            .controlSize(.extraLarge)
                                            .padding(.leading, paddingProgressView)
                                    }
                                } else {
                                    
                                    if let uiImage = image {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(minWidth: 0, maxWidth: ScreenSize.width, minHeight: 0, maxHeight: ScreenSize.height)
                                            .background(.pink)
                                            .cornerRadius(wAWCornerRadius)
                                            .padding()
                                            .onTapGesture {
                                                showImageOnFullScreen = true
                                            }
                                    }
                                }
                            }
                            
                            Text(reload ? emptyString : emptyString)
                        }
                        
                    }
                    
                    NavigationLink(destination: AstroCardView(), label: {
                        EmptyView()
                    })
                }
            }
            .onAppear {
                if let astro = astro {
                    loadData(astro: astro)
                }
            }
        }
        
    }
    
    // Methods
    private func loadData(astro: Astro) {
        // Data loading logic
        let urlString = loadHD ? astro.hdurl : astro.url
        
        if let urlString = urlString, let key = astro.date {
            DispatchQueue.global().async {
                AstroDetailViewModel().getData(urlString: urlString, key: key, isHD: loadHD) { uiImage, error  in
                    DispatchQueue.main.async {
                        
                        if error == nil {
                            self.image = uiImage
                            self.error = nil
                        } else {
                            self.error = error
                        }
                        self.showProgressView = false
                        self.reload.toggle()
                        
                    }
                }
            }
        }
    }
}

