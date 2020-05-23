//
//  Filter.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct Filter: View {
    @Binding var selected: FilterOption
    
    var body: some View {
        
        HStack {
            Picker(selection: $selected, label: EmptyView()) {
                ForEach(FilterOption.allCases, id: \.rawValue) {
                    Text($0.rawValue).tag($0)
                }
            }
        }
    }
}

struct Filter_Previews: PreviewProvider {
    
    static var previews: some View {
        Filter(selected: .constant(.all))
    }
}

enum FilterOption: String, CaseIterable {
    
    case all = "All"
    case connected = "Connected"
}
