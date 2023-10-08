//
//  InfoPanelView.swift
//  LookAtThis
//
//  Created by Yasin Cetin on 7.10.2023.
//

import SwiftUI

struct InfoPanelView: View {
    
    var offset: CGSize
    var scale: CGFloat
    @State private var isInfoPanelVisible: Bool = false
    
    var body: some View {
        
        HStack{
            // MARK: - Hotspot
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }
            
            Spacer()
            
        // MARK: - Info Panel
            HStack(spacing: 2){
                
                Spacer()
                
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                
                Spacer()
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                 
            }
            .padding(8)
            .font(.footnote)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .opacity(isInfoPanelVisible ? 1 : 0)
        }
        .padding()
        
    }
}

#Preview {
    InfoPanelView(offset: .zero, scale: 1)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .previewLayout(.sizeThatFits)
        .padding()
}
