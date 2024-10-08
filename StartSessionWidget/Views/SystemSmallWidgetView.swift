//
//  SystemSmallWidgetView.swift
//  StudyHelper
//
//  Created by Jannis Gehring on 09.05.24.
//

import SwiftUI

struct SystemSmallWidgetView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text("New session")
                .bold()
                .frame(maxHeight: 30)
                .minimumScaleFactor(0.6)
            Image(systemName: "play.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Spacer()
        }
        .foregroundStyle(.blue)
        .padding(5)
        .frame(maxWidth: 120)
    }
}

#Preview {
    SystemSmallWidgetView()
}
