//
//  DeleteButton.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 15/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct DestructiveButton: View {
    
    typealias Action = () -> ()
    
    let text: String
    let action: Action?
    
    init() {
        self.init(text: "Delete", action: nil)
    }
    
    init(text: String, action: Action?) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Text(self.text)
            .font(.headline)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Color.red)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(5)
            .onTapGesture { self.action?() }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    
    static var previews: some View {
        DestructiveButton()
    }
}
