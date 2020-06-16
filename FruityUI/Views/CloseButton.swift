//
//  CloseButton.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 16/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct CircularButton: View {
    typealias Action = () -> ()
    
    let action: Action?
    
    init() {
        self.init(action: nil)
    }
    
    init(action: Action?) {
        self.action = action
    }
    
    var body: some View {
        Text("✕")
            .font(.headline)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.gray)
            .clipShape(Circle())
            .foregroundColor(.white)
            .padding(5)
            .onTapGesture { self.action?() }
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularButton()
    }
}
