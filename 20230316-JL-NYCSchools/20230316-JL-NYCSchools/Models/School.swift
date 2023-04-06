//
//  School.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import Foundation

struct School: Codable, Hashable {
    var dbn: String
    var name: String
    var neighborhood: String
    var satData: SATData? = nil // default to nil as first network call does not get this
    
    // CaseIterable so networking can iterate over them. allowing us to coalese into a select string for network call
    enum CodingKeys: String, CodingKey, CaseIterable {
        case dbn
        case name = "school_name"
        case neighborhood
    }
    
    
}

// left this struct inside this file as it's only used as part of a School object
struct SATData: Codable, Hashable {
    var satTakerCount: String
    var satReadingAvgScore: String
    var satMathAvgScore: String
    var satWritingAvgScore: String
    
    // NOT CaseIterable because we're obtaining all data on network call, so don't need to coalese the cases into a string
    enum CodingKeys: String, CodingKey {
        case satTakerCount = "num_of_sat_test_takers"
        case satReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}
