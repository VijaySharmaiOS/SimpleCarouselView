//
//  CarouselView.swift
//  Atlys_Carousel
//
//  Created by VJ on 26/10/25.
//

import SwiftUI

struct SimpleCarouselView: View {
    
    let images: [String]
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 40) { // spacing between carousel and page control
            GeometryReader { outerGeometry in
                let screenWidth = outerGeometry.size.width
                let cardWidth = screenWidth * 0.7 // each image takes 70% of screen width
                let sidePadding = (screenWidth - cardWidth) / 2 // equal space on both sides
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(images.indices, id: \.self) { index in
                            GeometryReader { innerGeometry in
                                let midX = innerGeometry.frame(in: .global).midX
                                let diff = abs(screenWidth / 2 - midX)
                                let scale = max(0.9, 1.0 + 0.1 * (1 - diff / (screenWidth / 2))) // scale effect for center image
                                
                                Image(images[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: cardWidth, height: cardWidth)
                                    .cornerRadius(15)
                                    .shadow(radius: 4)
                                    .scaleEffect(scale) // zoom center image slightly
                                    .animation(.easeOut(duration: 0.3), value: scale)
                            }
                            .frame(width: cardWidth, height: cardWidth)
                        }
                    }
                    .padding(.horizontal, sidePadding) // keep carousel centered
                }
                .content.offset(x: -CGFloat(currentIndex) * cardWidth) // move scroll based on current index
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let offset = value.translation.width
                            let newIndex = (CGFloat(currentIndex) - offset / cardWidth).rounded()
                            currentIndex = min(max(Int(newIndex), 0), images.count - 1) // swipe logic
                        }
                )
                .frame(height: cardWidth)
            }
            .frame(height: 250) // set height for GeometryReader
            
            // Page control dots
            HStack(spacing: 6) {
                ForEach(images.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.blue : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut(duration: 0.2), value: currentIndex)
                }
            }
            .padding(.bottom, 8)
        }
        .onAppear {
            currentIndex = 0 // start from 1st index
        }
    }
}

#Preview {
    SimpleCarouselView(images: ["image1", "image2", "image3"])
}
