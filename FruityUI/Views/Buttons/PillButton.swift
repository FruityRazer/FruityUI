//
//  PillButton.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 16/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct PillButton: View {
    
    typealias Action = () -> ()
    
    let text: String
    let action: Action?
    
    init(text: String, action: Action?) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color.gray)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(2)
            .onTapGesture { self.action?() }
    }
}

struct PillButton_Previews: PreviewProvider {
    
    static var previews: some View {
        PillButton(text: "Lorem Ipsum", action: nil)
    }
}
