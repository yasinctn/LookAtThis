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
    @State private var imageOffset: CGSize = .zero
    
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
                    .offset(CGSize(width: imageOffset.width, height: imageOffset.height))
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
                
                //MARK: - Drag Gesture
                
                    .gesture(
                        DragGesture()
                        .onChanged { changedValue in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = changedValue.translation
                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                withAnimation(.linear(duration: 0.5)) {
                                    imageScale = 1
                                    imageOffset = .zero
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
