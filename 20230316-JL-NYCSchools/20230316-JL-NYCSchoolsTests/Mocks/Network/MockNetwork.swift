//
//  MockNetwork.swift
//  20230316-JL-NYCSchoolsTests
//
//  Created by JEFFREY LOSAPIO on 3/17/23.
//

import Foundation
import Combine
@testable import _0230316_JL_NYCSchools

class MockNetwork: NetworkInterface {
    var highSchoolList: [School]
    var satData: SATData
    var shouldFail: Bool
    
    // TODO: consider making this message configurable
    private var testErrorDescription = "test_error"
    private var testError: NSError
    
    init(highSchoolList: [School], satData: SATData, shouldFail: Bool = false) {
        self.highSchoolList = highSchoolList
        self.satData = satData
        self.shouldFail = shouldFail
        
        // setup test error
        self.testError = NSError(
            domain: "",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey : testErrorDescription]
        )
    }
    
    func getHighSchoolList() -> AnyPublisher<[School]?, Error> {
        if shouldFail {
            return Fail<[School]?, Error>(error: testError)
                .eraseToAnyPublisher()
        }
        return Just(highSchoolList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getSATResult(for dbn: String) -> AnyPublisher<SATData, Error> {
        if shouldFail {
            return Fail<SATData, Error>(error: testError)
                .eraseToAnyPublisher()
        }
        return Just(satData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
