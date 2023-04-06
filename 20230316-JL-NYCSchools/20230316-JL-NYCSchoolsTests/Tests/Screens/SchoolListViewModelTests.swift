//
//  SchoolListViewModelTests.swift
//  20230316-JL-NYCSchoolsTests
//
//  Created by JEFFREY LOSAPIO on 3/17/23.
//

import XCTest
import Quick
import Nimble
@testable import _0230316_JL_NYCSchools

final class SchoolListViewModelTests: QuickSpec {
    var target: SchoolListViewModel!
    var network: MockNetwork!
    
    override func spec() {
        afterEach {
            self.target = nil
            self.network = nil
        }
        
        describe("a SchoolList") {
            context("with a valid network connection") {
                beforeEach {
                    self.network = MockFactory.getMockNetwork(shouldFail: false)
                    self.target = SchoolListViewModel(network: self.network)
                }
                
                context("is first initialized") {
                    it("has an empty school list") {
                        expect(self.target.highSchoolList).to(equal([]))
                    }
                }
                
                context("requests a school list from the API successfully") {
                    beforeEach {
                        self.target.refreshSchoolList()
                    }
                    
                    it("toggles isLoading to true") {
                        expect(self.target.isLoading).to(beTrue())
                    }
                    
                    it("updates the school list") {
                        // TODO: Unsure how to resolve warning from lib, but it appears to be working as intended even with it
                        expect(self.target.highSchoolList).toEventuallyNot(equal([]))
                    }
                    
                    it("toggles isLoading back to false") {
                        // TODO: Unsure how to resolve warning from lib, but it appears to be working as intended even with it
                        expect(self.target.isLoading).toEventually(beFalse())
                    }
                }
            }
            
            context("with an invalid network connection") {
                beforeEach {
                    self.network = MockFactory.getMockNetwork(shouldFail: true)
                    self.target = SchoolListViewModel(network: self.network)
                }
                
                context("requests a school list from the API and fails") {
                    beforeEach {
                        self.target.refreshSchoolList()
                    }
                    
                    it("continues to have an empty school list") {
                        // TODO: Unsure how to resolve warning from lib, but it appears to be working as intended even with it
                        expect(self.target.highSchoolList).toAlways(equal([]))
                    }
                }
            }
        }
    }
}
