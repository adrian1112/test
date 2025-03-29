//
//  APIServices.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = "\(baseURL)/users"
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [User].self) { response in
                switch response.result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    func deleteUSer(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(baseURL)/users/\(id)"
        AF.request(url, method: .delete)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                }
            }
    }
}
