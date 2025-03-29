//
//  UserModel.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    var name: String?
    let username: String?
    var email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
    
    init() {
        self.id = 0
        self.name = ""
        self.username = ""
        self.email = ""
        self.address = nil
        self.phone = ""
        self.website = ""
        self.company = nil
    }
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo: Codable {
    let lat: String?
    let lng: String?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}
