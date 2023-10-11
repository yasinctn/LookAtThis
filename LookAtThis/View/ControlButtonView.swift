//
//  ControlButtonView.swift
//  LookAtThis
//
//  Created by Yasin Cetin on 8.10.2023.
//

import SwiftUI

struct ControlButtonView: View {
    
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 30))
            
        
    }
}

#Preview {
    ControlButtonView(icon: "minus.magnifyingglass")
        .preferredColorScheme(.dark)
        .padding()
}
