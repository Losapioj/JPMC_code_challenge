//
//  SchoolDetailsViewModel.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import Foundation
import SwiftUI

class SchoolDetailsViewModel: BaseViewModel {
    @Published var school: School
    private var network: NetworkInterface
    
    init(school: School, network: NetworkInterface) {
        self.school = school
        self.network = network
        
        super.init()
        
        self.isLoading = school.satData == nil
        
        if self.isLoading {
            getSATResults()
        }
    }
    
    func getSATResults() {
        network.getSATResult(for: school.dbn)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let e):
                    // TODO: Move Alerter to init to support unit testing
                    Alerter.shared.alert = Alert(title: Text("network_error"), message: Text(e.localizedDescription))
                default:
                    break
                }
                self.isLoading = false
            }, receiveValue: { satData in
                // TODO: struct is pass by value, would need to have a data manager object as part of the Model to have this save globally and not need to re-pull each time you enter the detail screen.
                self.school.satData = satData
            })
            .store(in: &cancellableSet)
    }
}
