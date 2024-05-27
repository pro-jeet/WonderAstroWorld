//
//  AstroListView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

let ScreenSize = UIScreen.main.bounds
let padding: CGFloat = 30

struct AstroListView: View {
    
    @State var astroArray = AstroListViewModel().astroArray
    @State var reload = false
    @State var showCalendar = false
    @State private var date = Date()
    @State var error: String? = nil
    
    var dateLimit: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from: "1995-06-22")!
    }

    var body: some View {
        
        VStack {
            
            if astroArray == nil {
                if let error = error {
                    Text(error)
                        .font(.title)
                        .tint(.red)
                } else {
                    ProgressView()
                }
            } else {
                
                NavigationSplitView {
                    Text("Wonder Astronomy")
                        .toolbar {
                            ToolbarItem(placement: .automatic) {
                                
                                Button(action: {
                                    
                                    showCalendar.toggle()
                                    
                                }, label: {
                                    Image(systemName: "calendar.circle")
                                        .frame(width: 50, height: 50)
                                        .tint(.blue)
                                })
                                
                                                
                            }
                        }
                    
                    if showCalendar {
                        VStack {
                            
                            Text("Select date to view 'Astronomy Picture of the Day' for the last 7 days from the selected date.")
                                .font(.footnote)
                                                        
                            DatePicker("Date",
                                       selection: $date,
                                       in: dateLimit...Date(),
                                       displayedComponents: [.date])
                                .tint(.blue)
                            
                            Button(action: {
                                astroArray = nil
                                loadData()
                                showCalendar.toggle()
                            }, label: {
                                Text("Done")
                            })
                            
                            Text("Select the Date and Press Done!")
                                .font(.caption)

                        }
                        .padding()
                        
                    }
                    
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            
                            Text("Picture of the Day")
                                .font(.headline)
                                .padding()
                            
                            ForEach(astroArray!, id: \.self.explanation) { astro in
                                
                                NavigationLink(destination: AstroDetailView(astro: astro), label: {
                                    AstroCardView(astro: astro)
                                        .frame(minWidth: 280, maxWidth: .infinity, minHeight: 420, maxHeight: .infinity)
                                        .background(.secondary)
                                        .cornerRadius(10)
                                        .padding()
                                })
                                
                            }
                            .frame(alignment: .center)
                        }
                    }
                } detail: {
                    Text(reload ? "" : "Detail View")
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    func loadData() {
        DispatchQueue.global().async {
            AstroListViewModel().fetchAstroData(endDate: date, completion: { astroArray, error in
                DispatchQueue.main.async {
                    if error == nil {
                        self.astroArray = astroArray?.reversed()
                        self.reload.toggle()
                    } else {
                        self.error = error
                        self.reload.toggle()
                    }
                }
            })
        }
    }
}
