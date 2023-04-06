//
//  _0230316_JL_NYCSchoolsApp.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import SwiftUI

@main
struct _0230316_JL_NYCSchoolsApp: App {
    var body: some Scene {
        WindowGroup {
            SchoolListView(viewModel: SchoolListViewModel(network: Network.shared))
        }
    }
}
