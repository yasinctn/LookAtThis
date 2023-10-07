//
//  ContentView.swift
//  LookAtThis
//
//  Created by Yasin Cetin on 7.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1.0
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                Image("Porsche", bundle: nil)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 10.0))
                    .shadow(radius: 10)
                    .opacity(isAnimating ? 1 : 0)
                    .navigationTitle("Pinch & Zoom")
                    .navigationBarTitleDisplayMode(.inline)
                    .scaleEffect(imageScale)
                //MARK: - Double Tap Gesture
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring) {
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring) {
                                imageScale = 1
                            }
                        }
                    })
            }
            
            .onAppear(perform:{
                withAnimation(.linear(duration: 1)) {
                isAnimating = true
                }
            })
             
            
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
