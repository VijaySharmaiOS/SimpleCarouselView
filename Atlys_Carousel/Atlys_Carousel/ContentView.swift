//
//  ContentView.swift
//  Atlys_Carousel
//
//  Created by VJ on 26/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
         VStack(spacing: 30) {
             Text("Get Visas On Time")
                 .font(.title2)
                 .bold()
                 .padding(.top)

             SimpleCarouselView(images: ["malaysia", "dubai", "thailand"])
            
             Spacer()
         }
         .padding()
     }
}

#Preview {
    ContentView()
}
