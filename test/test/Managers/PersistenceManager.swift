//
//  PersistenceManager.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import RealmSwift
import Foundation

class PersistenceManager {
    private let realm: Realm
    static let shared = PersistenceManager()
    
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func createUser(users: [User], completion: @escaping (Result<Void, Error>) -> Void){
        do {
            try realm.write {
                for user in users {
                    print("user to save: ", user)
                    realm.add(user, update: .modified)
                }
            }
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getAllUsers() -> [User] {
        return Array(realm.objects(User.self))
    }
    
    func updateUser(whitUniqueID id: String, name: String?, email: String?, completion: @escaping (Result<Void, Error>) -> Void) {
            do {
                guard let existingUser = realm.object(ofType: User.self, forPrimaryKey: id) else {
                    let error = NSError(domain: "Manager", code: -1, userInfo: [NSLocalizedDescriptionKey: "User with id \(id) not found"])
                    completion(.failure(error))
                    return
                }
                try realm.write {
                    if let name = name{
                        existingUser.name = name
                    }
                    if let email = email{
                        existingUser.email = email
                    }
                }
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    
    func deleteUser(whitUniqueID id: String, completion: @escaping (Result<Void, Error>) -> Void) {
            do {
                guard let existingUser = realm.object(ofType: User.self, forPrimaryKey: id) else {
                    let error = NSError(domain: "Manager", code: -1, userInfo: [NSLocalizedDescriptionKey: "User with id \(id) not found"])
                    completion(.failure(error))
                    return
                }
                try realm.write {
                    realm.delete(existingUser)
                }
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    
    func deleteAllUsers() throws {
        try realm.write {
            realm.delete(realm.objects(User.self))
        }
    }
}
