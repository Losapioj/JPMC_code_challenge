//
//  Alerter.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/17/23.
//

import Foundation
import SwiftUI

class Alerter: ObservableObject {
    static var shared = Alerter()
    
    @Published var alert: Alert? {
        didSet { isShowingAlert = alert != nil }
    }
    @Published var isShowingAlert = false
}
