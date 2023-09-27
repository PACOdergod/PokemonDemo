//
//  Helpers.swift
//  PokemonDemo
//
//  Created by FAMM on 26/09/23.
//

import Foundation

extension Bundle {
//    func decode<T:Decodable>(file: String) -> T {
//        guard let url = self.url(forResource: file, withExtension: nil) else {
//            fatalError("no se encontro \(file)")
//        }
//        
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("no se puede cargar \(file)")
//        }
//        
//        let decoder = JSONDecoder()
//        
//        guard let loadedData = try? decoder.decode(T.self, from: data) else {
//            fatalError("no se pudo decodificar \(file)")
//        }
//        
//        return loadedData
//    }
//    
//    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping (T)->(), failure: @escaping (Error)->()) {
//        guard let url = URL(string: url) else {return}
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                if let error = error {
//                    failure(error)
//                }
//                return
//            }
//
//            do {
//                let serverData = try JSONDecoder().decode(T.self, from: data)
//                completion(serverData)
//            } catch {
//                failure(error)
//            }
//        }.resume()
//    }
}


class Helpers {
    static func callApi<T: Codable>(url: URL, model: T.Type, completion: @escaping (T)->Void, failure: @escaping (Error)->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(serverData)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }.resume()
    }
}
