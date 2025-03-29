//
//  UserModel.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation

import Foundation

import Foundation
import RealmSwift

class User: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var uniqueId: String = UUID().uuidString
    @Persisted var id: Int = 0
    @Persisted var name: String?
    @Persisted var username: String?
    @Persisted var email: String?
    @Persisted var address: Address?
    @Persisted var phone: String?
    @Persisted var website: String?
    @Persisted var company: Company?
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, address, phone, website, company
    }
    
    override init() {
        super.init()
        self.id = 0
        self.name = ""
        self.username = ""
        self.email = ""
        self.address = nil
        self.phone = ""
        self.website = ""
        self.company = nil
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        address = try container.decodeIfPresent(Address.self, forKey: .address)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        company = try container.decodeIfPresent(Company.self, forKey: .company)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(username, forKey: .username)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(website, forKey: .website)
        try container.encodeIfPresent(company, forKey: .company)
    }
}

class Address: Object, Codable {
    @Persisted var street: String?
    @Persisted var suite: String?
    @Persisted var city: String?
    @Persisted var zipcode: String?
    @Persisted var geo: Geo?
    
    enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode, geo
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decodeIfPresent(String.self, forKey: .street)
        suite = try container.decodeIfPresent(String.self, forKey: .suite)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
        geo = try container.decodeIfPresent(Geo.self, forKey: .geo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(street, forKey: .street)
        try container.encodeIfPresent(suite, forKey: .suite)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(zipcode, forKey: .zipcode)
        try container.encodeIfPresent(geo, forKey: .geo)
    }
}

class Geo: Object, Codable {
    @Persisted var lat: String?
    @Persisted var lng: String?
    
    enum CodingKeys: String, CodingKey {
        case lat, lng
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        lng = try container.decodeIfPresent(String.self, forKey: .lng)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(lat, forKey: .lat)
        try container.encodeIfPresent(lng, forKey: .lng)
    }
}

class Company: Object, Codable {
    @Persisted var name: String?
    @Persisted var catchPhrase: String?
    @Persisted var bs: String?
    
    enum CodingKeys: String, CodingKey {
        case name, catchPhrase, bs
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        catchPhrase = try container.decodeIfPresent(String.self, forKey: .catchPhrase)
        bs = try container.decodeIfPresent(String.self, forKey: .bs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(catchPhrase, forKey: .catchPhrase)
        try container.encodeIfPresent(bs, forKey: .bs)
    }
}
