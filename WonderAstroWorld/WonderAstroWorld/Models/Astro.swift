//
//  Astro.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//
/*
 The Astro struct represents astronomical data and conforms to the Codable protocol, enabling it to be easily serialized and deserialized from JSON.
 
 It contains properties corresponding to various attributes of astronomical data, such as copyright, date, explanation, etc.
 
 The CodingKeys enum is used to map between the JSON keys and the Swift property names. This allows flexibility in naming conventions between the JSON data and Swift code.
 
 The init(from:) initializer is implemented to decode values from a decoder. It decodes each property from the decoder based on its corresponding key in the CodingKeys enum.
 
 Optional chaining (decodeIfPresent) is used to handle cases where the JSON key may be missing or the value may be null. This prevents decoding errors and allows for graceful handling of missing or null values.
 */

import Foundation

// Struct representing astronomical data conforming to Codable protocol for easy serialization and deserialization
struct Astro : Codable {
    
    // Properties representing various attributes of astronomical data
    let copyright : String?
    let date : String?
    let explanation : String?
    let hdurl : String?
    let mediaType : String?
    let serviceVersion : String?
    let title : String?
    let url : String?

    // CodingKeys enum to map JSON keys to Swift properties
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

    // Custom initializer to decode values from a decoder
    init(from decoder: Decoder) throws {
        
        // Decode values for each property based on its key
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
