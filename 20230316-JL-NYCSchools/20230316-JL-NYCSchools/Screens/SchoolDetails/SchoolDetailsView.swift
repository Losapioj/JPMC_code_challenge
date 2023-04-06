//
//  SchoolDetailsView.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/16/23.
//

import SwiftUI

struct SchoolDetailsView: View {
    @StateObject var viewModel: SchoolDetailsViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingSpinnerView()
            } else {
                // TODO: pull these text assets into localizable strings
                HStack {
                    Text("school_name_label")
                    Spacer()
                    Text(viewModel.school.name)
                }
                Divider()
                HStack {
                    Text("neighborhood_label")
                    Spacer()
                    Text(viewModel.school.neighborhood)
                }
                Divider()
                if let satData = viewModel.school.satData {
                    HStack {
                        Text("sat_taker_label")
                        Spacer()
                        Text(satData.satTakerCount)
                    }
                    HStack {
                        Text("avg_reading_score_label")
                        Spacer()
                        Text(satData.satReadingAvgScore)
                    }
                    HStack {
                        Text("avg_math_score_label")
                        Spacer()
                        Text(satData.satMathAvgScore)
                    }
                    HStack {
                        Text("avg_writing_score_label")
                        Spacer()
                        Text(satData.satWritingAvgScore)
                    }
                } else {
                    Text("no_sat_data")
                        .bold()
                }
            }
        }
    }
}

struct SchoolDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailsView(
            viewModel: SchoolDetailsViewModel(
                school: School(
                    dbn: "",
                    name: "",
                    neighborhood: ""),
            network: Network.shared))
    }
}
