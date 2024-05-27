//
//  AstroDetailView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

struct AstroDetailView: View {
    
    var astro: Astro?
    @State private var image: UIImage?
    
    @State private var loadHD = false
    @State private var expanded = false
    @State private var showProgressView = false
    @State private var error: String?
    @State private var reload = false
    @State private var showImageOnFullScreen = false
    
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
    
    var body: some View {
        
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
                            } else {
                                
                                if image == nil {
                                    if let error = error {
                                        Text(error)
                                            .font(.title)
                                            .tint(.red)
                                    } else {
                                        ProgressView()
                                    }
                                } else {
                                    
                                    if let uiImage = image {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(minWidth: 0, maxWidth: ScreenSize.width, minHeight: 0, maxHeight: ScreenSize.height)
                                            .background(.pink)
                                            .cornerRadius(WAWCornerRadius)
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
    
    private func loadData(astro: Astro) {
        
        let urlString = loadHD ? astro.hdurl : astro.url
        
        if let urlString = urlString, let key = astro.date {
            DispatchQueue.global().async {
                AstroDetailViewModel().getData(urlString: urlString, key: key, isHD: loadHD) { uiImage, error  in
                    DispatchQueue.main.async {
                        
                        if error == nil {
                            self.image = uiImage
                        } else {
                            self.error = nil
                        }
                        self.showProgressView = false
                        self.reload.toggle()
                        
                    }
                }
            }
        }
    }
}

