//
//  Network.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import Foundation
import Combine

protocol NetworkInterface {
    func getHighSchoolList() -> AnyPublisher<[School]?, Error>
    func getSATResult(for dbn: String) -> AnyPublisher<SATData, Error>
}

class Network: NetworkInterface {
    static var shared = Network()
    
    func getHighSchoolList() -> AnyPublisher<[School]?, Error> {
        
        var components = getBaseComponent()
        components.path = "/resource/s3k6-pzi2.json"
        
        // create select for coding keys only so we can greatly reduce the size of the network response
        var selectItems = ""
        for item in School.CodingKeys.allCases {
            if selectItems != "" {
                selectItems += ", "
            }
            selectItems += item.rawValue
        }
        
        components.queryItems?.append(.init(name: "$select", value: selectItems))
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [School]?.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getSATResult(for dbn: String) -> AnyPublisher<SATData, Error> {
        var components = getBaseComponent()
        components.path = "/resource/f9bf-2cp4.json"
        components.queryItems?.append(.init(name: "dbn", value: dbn))
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [SATData].self, decoder: JSONDecoder())
            .map { dataArray in
                return dataArray.first
            }
            .compactMap{ $0 }
            .eraseToAnyPublisher()
    }
}

extension Network {
    private func getBaseComponent() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "data.cityofnewyork.us"
        // TODO: Tokens could be moved to the header if it needed to be encrypted. Decided to put it here because it's a public API and there's no security concern
        components.queryItems = [.init(name: "$$app_token", value: "DSPFbCKxtwFeynS2y01ROvqLo")]
        
        return components
    }
}
