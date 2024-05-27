//
//  AstroListView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

struct AstroListView: View {
    
    @State private var astroArray = AstroListViewModel().astroArray
    @State private var reload = false
    @State private var showCalendar = false
    @State private var date = Date()
    @State private var error: String? = nil
    
    var dateLimit: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: lowerDateLimit)!
    }
    
    private let dateFormat = "YYYY-MM-dd"
    private let lowerDateLimit = "1995-06-22"
    private let mainTitle = "Wonder Astronomy"
    private let calendarImageName = "calendar.circle"
    private let infoSelectDate = "Select date to view 'Astronomy Picture of the Day' for the last 7 days from the selected date."
    private let datePlaceholder = "Date"
    private let doneButtonTitle = "Done"
    private let doneButtonFootnote = "Select the Date and Press Done!"
    private let titleSection = "Picture of the Day"
    private let detailViewStaticText = "Detail View"
    private let emptyString = ""
    private let reloadButtonTitle = "Reload"
    private let calendarButtonSize: CGFloat = 50
    private let astroCardWidth: CGFloat = 280
    private let astroCardHeight: CGFloat = 420
    
    var body: some View {
        
        VStack {
            
            if astroArray == nil {
                if let error = error {
                    VStack {
                        Text(error)
                            .font(.title)
                            .tint(.red)
                        Button(action: {
                            loadData()
                        }, label: {
                            Text(reloadButtonTitle)
                        })
                    }
                } else {
                    ProgressView()
                }
            } else {
                
                NavigationSplitView {
                    Text(mainTitle)
                        .toolbar {
                            ToolbarItem(placement: .automatic) {
                                
                                Button(action: {
                                    
                                    showCalendar.toggle()
                                    
                                }, label: {
                                    Image(systemName: calendarImageName)
                                        .frame(width: calendarButtonSize, height: calendarButtonSize)
                                        .tint(.blue)
                                })
                                
                                                
                            }
                        }
                    
                    if showCalendar {
                        VStack {
                            
                            Text(infoSelectDate)
                                .font(.footnote)
                                                        
                            DatePicker(datePlaceholder,
                                       selection: $date,
                                       in: dateLimit...Date(),
                                       displayedComponents: [.date])
                                .tint(.blue)
                            
                            Button(action: {
                                astroArray = nil
                                loadData()
                                showCalendar.toggle()
                            }, label: {
                                Text(doneButtonTitle)
                            })
                            
                            Text(doneButtonFootnote)
                                .font(.caption)

                        }
                        .padding()
                        
                    }
                    
                    ScrollView {
                        LazyVStack(alignment: .center) {
                            
                            Text(titleSection)
                                .font(.headline)
                                .padding()
                            
                            ForEach(astroArray!, id: \.self.explanation) { astro in
                                
                                NavigationLink(destination: AstroDetailView(astro: astro), label: {
                                    AstroCardView(astro: astro)
                                        .frame(minWidth: astroCardWidth, maxWidth: .infinity, minHeight: astroCardHeight, maxHeight: .infinity)
                                        .background(.secondary)
                                        .cornerRadius(WAWCornerRadius)
                                        .padding()
                                })
                                
                            }
                            .frame(alignment: .center)
                        }
                    }
                } detail: {
                    Text(reload ? emptyString : detailViewStaticText)
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        DispatchQueue.global().async {
            AstroListViewModel().fetchAstroData(endDate: date, completion: { astroArray, error in
                DispatchQueue.main.async {
                    if error == nil {
                        self.astroArray = astroArray
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
