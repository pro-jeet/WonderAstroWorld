//
//  AstroDetailView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

struct AstroDetailView: View {
    
    var astro: Astro?
    @State var image: UIImage?
    
    @State var loadHD = false
    @State var expanded = false
    @State var showProgressView = false
    @State var error: String?
    @State var reload = false
    
    var body: some View {
        
        Text(astro?.title ?? "Title")
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
                        Text(loadHD ? "Normal" : "HD")
                    })
                                    
                }
            
            }
        
        Text(astro?.date ?? "Date")
            .font(.footnote)
            .bold()
        
        ScrollView {
            LazyVStack(alignment: .leading) {

                if let astro = astro {
                    VStack {
                        HStack {
                            Text(astro.explanation ?? "Explanation")
                                .lineLimit(expanded ? .max : 5)
                        }
                        .padding()
                        
                        Button(expanded ? "Read Less" : "Read More" ) {
                            expanded.toggle()
                        }
                        .font(.system(size: 15, weight: .semibold))
                    }
                                 
                    VStack (alignment: .center) {
                        
                        Text(loadHD ? "" : "")
                        
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
                                        .cornerRadius(10)
                                        .padding()
                                }
                            }
                        }
                        
                        Text(reload ? "" : "")
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
    
    func loadData(astro: Astro) {
        if loadHD {
            if let urlString = astro.hdurl, let key = astro.date {
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
        } else {
            if let urlString = astro.url, let key = astro.date {
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
}

