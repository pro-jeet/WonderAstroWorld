//
//  AstroListView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import SwiftUI

/**
 A SwiftUI view representing a list of astronomical data.

 This view displays a list of astronomical data fetched from NASA's Astronomy Picture of the Day (APOD) API. It allows users to select a date to view the "Astronomy Picture of the Day" for the last 7 days from the selected date.

 ## Properties:
 - `astroArray`: An array of astronomical data fetched from the API.
 - `reload`: A boolean value to trigger data reloading.
 - `showCalendar`: A boolean value to control the visibility of the date picker.
 - `date`: The selected date for fetching astronomical data.
 - `error`: An optional string representing any error occurred during data fetching.

 ## Constants:
 - Various constants used for UI styling and layout.

 ## Methods:
 - `loadData()`: Asynchronously loads astronomical data from the API based on the selected date.

 This view utilizes various SwiftUI components such as `NavigationLink`, `ScrollView`, and `LazyVStack` to display the list of astronomical data. It also includes a toolbar button to toggle the date picker, a date picker to select a date, and a reload button in case of an error during data fetching.
*/

struct AstroListView: View {
    
    // Properties
    @State private var astroArray = AstroListViewModel().astroArray
    @State private var reload = false
    @State private var showCalendar = false
    @State private var date = Date()
    @State private var error: String? = nil
    
    // Constants
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
    private let timeZone = "America/New_York"
    private let identifies = "NavigationCell"
    private let calendarButtonSize: CGFloat = 50
    private let astroCardWidth: CGFloat = 280
    private let astroCardHeight: CGFloat = 420
    private let ScreenSize = UIScreen.main.bounds
    private let wAWCornerRadius: CGFloat = 10
    
    var body: some View {
        // View hierarchy
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
                                       in: AstroListViewModel().dateLimit...Date(),
                                       displayedComponents: [.date])
                                .tint(.blue)
                                .environment(\.timeZone, TimeZone(identifier: timeZone)!)
                            
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
                                        .cornerRadius(wAWCornerRadius)
                                        .padding()
                                        .accessibilityIdentifier(identifies)
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
    
    // Methods
    private func loadData() {
        // Data loading logic
        DispatchQueue.global().async {
            AstroListViewModel().fetchAstroData(endDate: date, completion: { astroArray, error in
                DispatchQueue.main.async {
                    if error == nil {
                        self.astroArray = astroArray
                        self.reload.toggle()
                        self.error = nil
                    } else {
                        self.error = error
                        self.reload.toggle()
                    }
                    
                }
            })
        }
    }
}
