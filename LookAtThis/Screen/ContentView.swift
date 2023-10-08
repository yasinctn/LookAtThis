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
                Color.clear
                
                
                Image("Porsche", bundle: nil)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 10.0))
                    .shadow(radius: 10)
                    .opacity(isAnimating ? 1 : 0)
                    .navigationTitle("Pinch & Zoom")
                    .navigationBarTitleDisplayMode(.inline)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .padding()
                //MARK: - Double Tap Gesture
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring) {
                                imageScale = 4
                            }
                        } else {
                            withAnimation(.spring) {
                                imageScale = 1
                                imageOffset = .zero
                            }
                        }
                    })
                
                //MARK: - Drag Gesture
                
                    .gesture(
                        DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                                
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
            .overlay(alignment: .top) {
                InfoPanelView(offset: imageOffset, scale: imageScale)
            }
            
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
