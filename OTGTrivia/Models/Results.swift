//
//  Results.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/3/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let results = try? newJSONDecoder().decode(Results.self, from: jsonData)

import Foundation

enum Difficulty: String, Codable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    func description() -> String {
        switch self {
        case .easy:  return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
}

enum GameTypeEnum: String, Codable {
    case boolean = "boolean"
    case multiple = "multiple"
    
    func description() -> String {
        switch self {
        case .boolean:  return "True or False"
        case .multiple: return "Multiple Choice"
        }
    }
}

struct Results: Codable {
    let responseCode: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}
struct Result: Codable {
    let category: String
    let type: GameTypeEnum
    let difficulty: Difficulty
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    static func endpointForResults() -> String{
        return "https://opentdb.com/api.php"
    }
}


// With the introduction to Swift 4, we are now given more customization to parsing JSON. I decided to use the JSONDecoder for it makes it easier for me to define the properties that the JSON file gives to it. More customization and removes the clutter from the data structures' composition of the NSCoding protocol and traditional JSON parsing (If you parsed JSON between 2012-2015 in Obj-C, you understand). Also, making the data structure Codable would allow me to save the data off-line with the NSKeyedArchiver.
fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func resultsTask(with url: URL, completionHandler: @escaping (Results?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
