//
//  Animals.swift
//  Inno Wildlife
//
//  Created by Ahror Jabborov on 4/13/22.
//

import Foundation


struct Animal: Decodable {
    var avatar: String?
    var bio: String?
    var firstName: String?
    var id: String?
    var lastName: String?
    var title: String?
}

struct AnimalResponse: Decodable {
    var data: [Animal]?
}


struct AddEditAnimal: Codable {
    var bio: String?
    var firstName: String?
    var lastName: String?
    var title: String?
}
