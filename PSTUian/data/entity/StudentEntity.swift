//
//  StudentEntity.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/03.
//

import SwiftUI

struct StudentEntity: Codable, Identifiable {
    let id: Int
    let name: String
    let reg: String
    let phone: String?
    let linkedIn: String?
    let fbLink: String?
    let blood: String?
    let address: String?
    let email: String?
    let batchId: Int
    let session: String
    let facultyId: Int
    let imageUrl: String?
    let cvLink: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case reg
        case phone
        case linkedIn = "linked_in"
        case fbLink = "fb_link"
        case blood
        case address
        case email
        case batchId = "batch_id"
        case session
        case facultyId = "faculty_id"
        case imageUrl = "image_url"
        case cvLink = "cv_link"
        case bio
    }
}
