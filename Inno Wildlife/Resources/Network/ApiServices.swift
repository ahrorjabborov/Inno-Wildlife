//
//  ApiServices.swift
//  Inno Wildlife
//
//  Created by Ahror Jabborov on 4/13/22.
//

import Foundation

class ApiServices {
    static let shared = ApiServices()
    let baseUrl = "https://raw.githubusercontent.com/ahrorjabborov/animal_world/main/animals.json"
    
    
    
    
    func getAnimals(apiTail: String = "", completion: @escaping(Result<[Animal], CustomError>) -> Void) {
        let url = URL(string: "\(baseUrl)\(apiTail)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            do {
                let decoder = JSONDecoder()
                let dataResponse = try decoder.decode([Animal].self, from: data)
                let responseDetail = dataResponse
                completion(.success(responseDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
    
    
    
    
    func postAnimal(requestModel: AddEditAnimal, apiTail: String = "", completion: @escaping(Result<String, CustomError>) -> Void) {
        let url = URL(string: "\(baseUrl)\(apiTail)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String: Any] = ["bio": requestModel.bio ?? "",
                                   "firstName": requestModel.firstName ?? "",
                                   "lastName": requestModel.lastName ?? "",
                                   "title": requestModel.title ?? ""]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            do {
                let decoder = JSONDecoder()
                let dataResponse = try decoder.decode(String.self, from: data)
                let responseDetail = dataResponse
                completion(.success(responseDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
    
    
}


enum CustomError: Error {
    case noDataAvailable
    case canNotProcessData
}
