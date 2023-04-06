//
//  LoadingSpinnerView.swift
//  20230316-JL-NYCSchools
//
//  Created by JEFFREY LOSAPIO on 3/17/23.
//

import SwiftUI

struct LoadingSpinnerView: View {
    @State var isLoading = false
    
    var animation: Animation {
        Animation.linear(duration: 2.0)
                .repeatForever(autoreverses: false)
        }
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.green, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(self.isLoading ? animation : .default, value: isLoading)
            .onAppear {
                DispatchQueue.main.async {
                    isLoading = true
                }
            }
    }
}

struct LoadingSpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinnerView()
    }
}
