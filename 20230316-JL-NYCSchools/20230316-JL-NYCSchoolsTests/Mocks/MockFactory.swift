//
//  MockFactory.swift
//  20230316-JL-NYCSchoolsTests
//
//  Created by JEFFREY LOSAPIO on 3/17/23.
//

import Foundation
@testable import _0230316_JL_NYCSchools

class MockFactory {
    // MARK: - Models
    
    // MARK: School
    static let mockSchoolModelDBN = "mock_school_dbn"
    static let mockSchoolModelName = "mock_school_name"
    static let mockSchoolModelNeighborhood = "mock_school_neighborhood"
    static let mockSchoolModelSATDataModel = getMockSATData()
    
    static func getMockSchool(
        dbn: String = mockSchoolModelDBN,
        name: String = mockSchoolModelName,
        neighborhood: String = mockSchoolModelNeighborhood,
        satData: SATData? = mockSchoolModelSATDataModel
    ) -> School {
        return School(
            dbn: dbn,
            name: name,
            neighborhood: neighborhood,
            satData: satData
        )
    }
    
    // MARK: SATData
    static let mockSATDataModelTakerCount = "mock_sat_taker_count"
    static let mockSATDataModelReadingAvgScore = "mock_sat_reading_avg"
    static let mockSATDataModelMathAvgScore = "mock_sat_math_avg"
    static let mockSATDataModelWritingAvgScore = "mock_sat_writing_avg"
    
    static func getMockSATData(
        takerCount: String = mockSATDataModelTakerCount,
        readingAvg: String = mockSATDataModelReadingAvgScore,
        mathAvg: String = mockSATDataModelMathAvgScore,
        writingAvg: String = mockSATDataModelWritingAvgScore
    ) -> SATData {
        return SATData(
            satTakerCount: takerCount,
            satReadingAvgScore: readingAvg,
            satMathAvgScore: mathAvg,
            satWritingAvgScore: writingAvg
        )
    }
    
    // MARK: - Network
    static let mockNetworkHighSchoolList = [getMockSchool(), getMockSchool()]
    static let mockNetworkSATData = getMockSATData()
    static let mockNetworkShouldFail = false
    
    static func getMockNetwork(
        highSchoolList: [School] = mockNetworkHighSchoolList,
        satData: SATData = mockNetworkSATData,
        shouldFail: Bool = mockNetworkShouldFail
    ) -> MockNetwork {
        return MockNetwork(
            highSchoolList: highSchoolList,
            satData: satData,
            shouldFail: shouldFail
        )
    }
}
