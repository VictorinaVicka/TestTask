//
//  Bundle + Extension.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import Foundation

extension Bundle {

    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}



//class FileParsing {
//    func parse(completion: @escaping(Result<[MSection], Error>) -> Void) {
//        if let url = Bundle.main.path(forResource: "test", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
//                let json = try JSONDecoder().decode([MSection].self, from: data)
//                completion(.success(json))
//            } catch let error {
//                completion(.failure(error))
//            }
//        }
//    }
//}
