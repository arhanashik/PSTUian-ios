//
//  TeacherEntity.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/03.
//

import SwiftUI

class TeacherEntity: Codable, Identifiable {
    let id: Int
    let name: String
    let designation: String
    let bio: String?
    let phone: String?
    let linkedIn: String?
    let fbLink: String?
    let address: String?
    let email: String?
    let department: String?
    let blood: String?
    let facultyId: Int
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case designation
        case bio
        case phone
        case linkedIn = "linked_in"
        case fbLink = "fb_link"
        case address
        case email
        case department
        case blood
        case facultyId = "faculty_id"
        case imageUrl = "image_url"
    }
}
