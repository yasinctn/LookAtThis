//
//  ContentView.swift
//  LookAtThis
//
//  Created by Yasin Cetin on 7.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating = false
    @State private var isDrawerOpen = false
    @State private var imageScale: CGFloat = 1.0
    @State private var imageOffset: CGSize = .zero
    
    func resetImageState() {
        imageScale = 1
        imageOffset = .zero
    }
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                Color.clear
                
                // MARK: - Image
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
                                resetImageState()
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
                                        resetImageState()
                                    }
                                }
                                
                            })
                
                // MARK: - Magnification Gesture
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.linear) {
                                    if imageScale <= 5 {
                                        imageScale = value
                                    }else {
                                        imageScale = 5
                                    }
                                }
                            })
                            .onEnded({ _ in
                                withAnimation {
                                    if imageScale > 5 {
                                        imageScale = 5
                                    } else if imageScale < 1 {
                                        resetImageState()
                                    }
                                }
                            })
                    )
                
                //MARK: - Drawer
                
                .overlay(alignment: .topTrailing) {
                    
                    HStack {
                        Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 50)
                            .padding(12)
                            .foregroundStyle(.secondary)
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    isDrawerOpen.toggle()
                                }
                            }
                        Spacer()
                    }
                    .frame(width: 270)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 17))
                    .offset(x: isDrawerOpen ? 20 : 230)
                    
                }
            }
            
            .onAppear(perform:{
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            // MARK: - Info Panel
            .overlay(alignment: .top) {
                InfoPanelView(offset: imageOffset, scale: imageScale)
            }
            
            // MARK: - Control Buttons
            
            .overlay(alignment: .bottom) {
                Group{
                    HStack{
                        // MARK: - Zoom Out Button
                        Button {
                            withAnimation(.spring) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    
                                    if imageScale <= 1{
                                        imageScale = 1
                                    }
                                }
                            }
                        } label: {
                            ControlButtonView(icon: "minus.magnifyingglass")
                        }
                        // MARK: - Reset Button
                        Button {
                            withAnimation(.spring) {
                                resetImageState()
                            }
                            
                        } label: {
                            ControlButtonView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        // MARK: Zoom In Button
                        Button {
                            withAnimation(.spring) {
                                if imageScale < 5{
                                    imageScale += 1
                                }
                            }
                        } label: {
                            ControlButtonView(icon: "plus.magnifyingglass")
                        }
                    }.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    
                    
                    
                }
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.bottom,30)
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        
}
