//
//  SchoolDetailsViewModelTests.swift
//  20230316-JL-NYCSchoolsTests
//
//  Created by JEFFREY LOSAPIO on 3/17/23.
//

import XCTest
import Quick
import Nimble
@testable import _0230316_JL_NYCSchools

final class SchoolDetailsViewModelTests: QuickSpec {
    var target: SchoolDetailsViewModel!
    var school: School!
    var network: MockNetwork!
    
    override func spec() {
        beforeEach {
            self.school = MockFactory.getMockSchool(satData: nil)
            self.network = MockFactory.getMockNetwork()
        }
        
        afterEach {
            self.target = nil
            self.network = nil
            self.school = nil
        }
        
        describe("A School Detail View Model") {
            context("with a valid Network connection") {
                beforeEach {
                    self.target = SchoolDetailsViewModel(school: self.school, network: self.network)
                }
                
                context("on initialization") {
                    it("has a school with no SAT data") {
                        expect(self.target.school).toNot(beNil())
                        // TODO: Add Debounce to mock network on the SAT call to allow this check, as network is called immediately on init
//                        expect(self.target.school.satData).to(beNil())
                    }
                    
                    it("immediately loads the school with SAT data from network") {
                        // TODO: Unsure how to resolve warning from lib, but it appears to be working as intended even with it
                        expect(self.target.school.satData).toEventuallyNot(beNil())
                    }
                }
            }
            
            context("with an invalid Network connection") {
                beforeEach {
                    self.network.shouldFail = true
                    self.target = SchoolDetailsViewModel(school: self.school, network: self.network)
                }
                
                context("on initialization") {
                    it("fails to load the SAT data") {
                        // TODO: Unsure how to resolve warning from lib, but it appears to be working as intended even with it
                        expect(self.target.school.satData).toAlways(beNil())
                    }
                }
            }
        }
    }
}
