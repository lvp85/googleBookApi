//
//  GoogleApiBook.swift
//  googleBookApi
//
//  Created by Udagedara Dehigama on 2021/12/29.
//

import Foundation

struct GoogleApiBook : Codable {
    let items:[Items]
}
struct Items: Codable {
    let volumeInfo: VolumeInfo
   
}
struct VolumeInfo: Codable {
    let title : String
    let description: String?
   let imageLinks: ImageLinks
}
struct ImageLinks: Codable {
    let thumbnail: String
    
}
