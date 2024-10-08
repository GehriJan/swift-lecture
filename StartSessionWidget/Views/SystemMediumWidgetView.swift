//
//  SystemMediumWidgetView.swift
//  StudyHelper
//
//  Created by Jannis Gehring on 09.05.24.
//

import SwiftUI

struct SystemMediumWidgetView: View {
    
    var hoursToGo: Int
    let startSession: URL = URL(string: "startSession")!
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                HStack {
                    Text("Over")
                    Text("\(hoursToGo)")
                        .font(.system(size: 80, weight: .heavy))
                }
                Text("hours left to study today!")
            }
            Spacer()
            VStack {
                Link(destination: startSession) {
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
            Spacer()
        }
    }
}
