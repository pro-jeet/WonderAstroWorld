//
//  Astro.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

import Foundation
struct Astro : Codable {
    let copyright : String?
    let date : String?
    let explanation : String?
    let hdurl : String?
    let mediaType : String?
    let serviceVersion : String?
    let title : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case copyright = "copyright"
        case date = "date"
        case explanation = "explanation"
        case hdurl = "hdurl"
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title = "title"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        explanation = try values.decodeIfPresent(String.self, forKey: .explanation)
        hdurl = try values.decodeIfPresent(String.self, forKey: .hdurl)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
        serviceVersion = try values.decodeIfPresent(String.self, forKey: .serviceVersion)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
