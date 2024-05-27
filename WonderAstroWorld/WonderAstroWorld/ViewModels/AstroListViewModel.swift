//
//  AstroListViewModel.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

class AstroListViewModel: ObservableObject {
    
    private let dateFormat = "YYYY-MM-dd"
    private let lowerDateLimit = "1995-06-22"
    
    @Published var astroArray: [Astro]? = nil
    
    var dateLimit: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")!
        return dateFormatter.date(from: lowerDateLimit)!
    }
    
    func fetchAstroData(endDate: Date, completion: @escaping ([Astro]?, String?) -> Void) {
        
        let startDateString = getStartDate(endDate: endDate)
        let endDateString = getEndDate(date: endDate)
        
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=s06Eyw4j4relR5FC3nb03VcPJWxvYBCpNYqSMViX&start_date=" + startDateString + "&end_date=" + endDateString
        
        print(urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
          
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
 
    func getEndDate(date: Date) -> String {
        if let endDate = Calendar.current.date(byAdding: .day, value: 0, to: date) {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "America/New_York")!

            let dateString = dateFormatter.string(from: endDate)
            return dateString
        } else {
            return "Invalid Date"
        }
    }
    
    func getStartDate(endDate: Date) -> String {
        if let startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "America/New_York")!
            let dateString = dateFormatter.string(from: startDate)
            return dateString
        } else {
            return "InValid date"
        }
    }
}
