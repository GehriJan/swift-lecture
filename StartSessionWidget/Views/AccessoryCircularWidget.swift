//
//  AccessoryCircularWidget.swift
//  StudyHelper
//
//  Created by Jannis Gehring on 11.05.24.
//

import SwiftUI

struct AccessoryCircularWidget: View {
    var body: some View {
        VStack {
            Text("New session")
                .fontWeight(.heavy)
                .frame(maxHeight: 30)
                .minimumScaleFactor(0.6)
        }
        .padding(5)
    }
}

#Preview {
    AccessoryCircularWidget()
}
