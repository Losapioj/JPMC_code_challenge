//
//  SchoolListViewModel.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import Foundation
import Combine
import SwiftUI

class SchoolListViewModel: BaseViewModel {
    // TODO: could change to optional and start at nil. This would allow us to differentiate between first launch and a data load with an empty set for the view to display to the user
    @Published var highSchoolList: [School] = []
    private var network: NetworkInterface
    
    init(network: NetworkInterface) {
        self.network = network
    }
    
    func refreshSchoolList() {
        self.isLoading = true
        
        network.getHighSchoolList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let e):
                    // TODO: Move Alerter to init to support unit testing
                    Alerter.shared.alert = Alert(title: Text("network_error"), message: Text(e.localizedDescription))
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { schoolList in
                let concreteList = schoolList ?? []
                self.highSchoolList = concreteList
            })
            .store(in: &cancellableSet)
    }
}
