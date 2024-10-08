//
//  AccessoryRectangularWidget.swift
//  StudyHelper
//
//  Created by Jannis Gehring on 11.05.24.
//

import SwiftUI

struct AccessoryRectangularWidget: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "play.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text("New session")
                .fontWeight(.heavy)
                .frame(maxHeight: 30)
                .minimumScaleFactor(0.6)
            Spacer()
        }
        .backgroundStyle(.black)
        .opacity(0.7)
        .padding(5)
        .frame(maxWidth: 120)
    }
}

#Preview {
    AccessoryRectangularWidget()
}
