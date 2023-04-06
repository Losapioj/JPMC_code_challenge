//
//  BaseViewModel.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    var cancellableSet = Set<AnyCancellable>()
}
