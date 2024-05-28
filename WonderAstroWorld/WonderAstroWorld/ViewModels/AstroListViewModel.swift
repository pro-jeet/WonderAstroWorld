//
//  AstroListViewModel.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

/**
 A view model responsible for managing the data related to astronomical information fetched from NASA's Astronomy Picture of the Day (APOD) API.

 This view model fetches data for a specified date range and provides methods to retrieve astronomical data.

 ## Properties:
 - `dateFormat`: A string representing the date format used throughout the view model.
 - `lowerDateLimit`: A string representing the lower limit date for fetching astronomical data.
 - `baseURL`: The base URL for the APOD API.
 - `startDateKeyURL`: The key used in the API URL for specifying the start date.
 - `endDateKeyURL`: The key used in the API URL for specifying the end date.
 - `timeZone`: The time zone used for date formatting and API requests.
 - `plistFileName`: The name of the property list file containing the API key.
 - `plistFileType`: The file type of the property list file.
 - `plistKeyName`: The key name for accessing the API key in the property list.

 - `astroArray`: An array of `Astro` objects representing the fetched astronomical data. Published to automatically update views when the data changes.

 ## Methods:
 - `dateLimit`: Computed property returning the lower date limit as a `Date` object.
 - `fetchAstroData(endDate:completion:)`: Fetches astronomical data for the specified end date, calling the completion handler with the fetched data or an error message.
 - `getEndDate(date:)`: Returns the formatted end date string for the API request.
 - `getStartDate(endDate:)`: Returns the formatted start date string for the API request.
 - `getAPIKey()`: Retrieves the API key from the app's property list file.

 - Note: This class requires a valid API key stored in a property list file named "AppData.plist" with the key name "API_KEY".
*/

class AstroListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let dateFormat = "YYYY-MM-dd"
    private let lowerDateLimit = "1995-06-22"
    private let baseURL = "https://api.nasa.gov/planetary/apod?api_key="
    private let startDateKeyURL = "&start_date="
    private let endDateKeyURL = "&end_date="
    private let timeZone = "America/New_York"
    private let plistFileName = "AppData"
    private let plistFileType = "plist"
    private let plistKeyName = "API_KEY"
    
    @Published var astroArray: [Astro]? = nil
    
    // MARK: - Computed Properties
    
    /// Returns the lower date limit as a `Date` object.
    var dateLimit: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(identifier: timeZone)!
        return dateFormatter.date(from: lowerDateLimit)!
    }
    
    // MARK: - Methods
    
    /**
         Fetches astronomical data for the specified end date.

         - Parameters:
            - endDate: The end date for the data fetch.
            - completion: A closure to be called upon completion of the fetch operation. It returns the fetched data or an error message.
    */
    
    func fetchAstroData(endDate: Date, completion: @escaping ([Astro]?, String?) -> Void) {
        
        let startDateString = getStartDate(endDate: endDate)
        let endDateString = getEndDate(date: endDate)
        
        guard let apiKey = getAPIKey() else { completion(nil, MyError.failedRetrivingAPIKey.errorDescription)
            return
        }
        
        let urlString = baseURL + apiKey + startDateKeyURL + startDateString + endDateKeyURL + endDateString
        
        print(urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        let apiClient = APIClient()
        apiClient.sendRequests(type: [Astro].self, request: request) { result in
            switch result {
                case .success(let astroArray):
                completion(astroArray.reversed(), nil)
                case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    /**
        Returns the formatted end date string for the API request.
        
        - Parameter date: The end date for the API request.
        - Returns: A formatted string representing the end date.
    */
    func getEndDate(date: Date) -> String {
        if let endDate = Calendar.current.date(byAdding: .day, value: 0, to: date) {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            dateFormatter.timeZone = TimeZone(identifier: timeZone)!

            let dateString = dateFormatter.string(from: endDate)
            return dateString
        } else {
            return MyError.invalidData.localizedDescription
        }
    }
    
    /**
         Returns the formatted start date string for the API request.
         
         - Parameter endDate: The end date used to calculate the start date.
         - Returns: A formatted string representing the start date.
    */
    func getStartDate(endDate: Date) -> String {
        if let startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            dateFormatter.timeZone = TimeZone(identifier: timeZone)!
            let dateString = dateFormatter.string(from: startDate)
            return dateString
        } else {
            return MyError.invalidData.localizedDescription
        }
    }
    
    /**
     Retrieves the API key from the app's property list file.

     - Returns: The API key if found, otherwise nil.

     This method attempts to retrieve the API key stored in a property list file named "AppData.plist". It first attempts to locate the file using the provided file name and type. If the file is found, it reads its contents as data. Then, it attempts to deserialize the data into a property list format. If successful, it checks if the deserialized data is a dictionary, and if so, it attempts to extract the API key from it using the provided key name. If the key is found, it returns it; otherwise, it returns nil. Any errors encountered during this process are printed to the console.
    */
    private func getAPIKey() -> String? {
        
        if let path = Bundle.main.path(forResource: plistFileName, ofType: plistFileType) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
                    if let dict = plistData as? [String: Any] {
                        // Access Plist data here
                        if let key = dict[plistKeyName] as? String {
                            return key
                        }
                    }
                } catch {
                    print(MyError.failedRetrivingAPIKey.errorDescription ?? "")
                }
            }
        }
        return nil
    }
}
