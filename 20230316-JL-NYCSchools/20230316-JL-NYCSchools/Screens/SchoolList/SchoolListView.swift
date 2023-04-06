//
//  SchoolListView.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import SwiftUI

struct SchoolListView: View {
    @StateObject var viewModel: SchoolListViewModel
    @StateObject var alerter: Alerter = Alerter.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if viewModel.highSchoolList.count != 0 {
                        ForEach(viewModel.highSchoolList, id: \.self) { school in
                            // TODO: Fine since these are only used here, but could pull out the creation of the cell into its own file if its needed elsewhere as well.
                            NavigationLink(
                                destination: SchoolDetailsView(
                                    viewModel: SchoolDetailsViewModel(
                                        school: school,
                                        network: Network.shared
                                    )
                                )
                            ) {
                                VStack {
                                    Text(school.name)
                                        .font(.headline)
                                    Text(school.neighborhood)
                                        .font(.subheadline)
                                }
                            }
                        }
                    } else {
                        Text("pull_to_refresh")
                            .multilineTextAlignment(.center)
                    }
                }
                .refreshable {
                    viewModel.refreshSchoolList()
                }
            }
            .navigationTitle("highschool_list_title")
        }
        .listStyle(.automatic)
        // Set on root view, allows alerts to be presented from ANY file
        .alert(isPresented: $alerter.isShowingAlert) {
            alerter.alert ?? Alert(title: Text(""))
        }
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView(viewModel:
                        SchoolListViewModel(network: Network.shared))
    }
}
