//
//  PickerView.swift
//  StudyHelper
//
//  Created by Jannis Gehring on 09.05.24.
//

import SwiftUI

struct PickerView: View {
    
    @Binding var selectedConfig: Configs
    
    
    var body: some View {
        Picker("", selection: $selectedConfig) {
            Text("25min • 5min").tag(Configs.short)
            Text("50min • 10min").tag(Configs.middle)
            Text("75min • 15min").tag(Configs.long)
        }
        .pickerStyle(.menu)
        .buttonStyle(.bordered)
        .padding()
    }
}
