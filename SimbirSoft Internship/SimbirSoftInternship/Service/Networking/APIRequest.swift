//
//  APIRequest.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//

import Foundation

protocol APIRequest {
	associatedtype Response
	
	var path: String { get }
}

extension APIRequest {
	var request: URLRequest {
		var components = URLComponents()
		
		components.scheme = "https"
		components.host = "62ee9c46f5521ecad578ad57.mockapi.io"
		components.path = path
		
		return URLRequest(url: components.url!)
	}
}

extension APIRequest where Response: Decodable {
	func send(completion: @escaping (Result<Response, Error>) -> Void) {
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			do {
				if let data = data {
					let decoded = try JSONDecoder().decode(Response.self, from: data)
					completion(.success(decoded))
				} else if let error = error {
					completion(.failure(error))
				}
			} catch let error as NSError {
				print("Error fetch data from server: \(error), \(error.userInfo)")
			}
		}.resume()
	}
}
