//
//  ContentView.swift
//  TextShimmerEffect
//
//  Created by Maxim Macari on 29/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    //Toggle for multicolor
    @State var multiColor = false
    
    var body: some View {
        VStack(spacing: 15){
            
            TextShimmer(text: "Entrance", multiColors: $multiColor)
            
            TextShimmer(text: "Service Line", multiColors: $multiColor)
            
            TextShimmer(text: "Exit", multiColors: $multiColor)
            
            Toggle(isOn: $multiColor, label: {
                Text("Enablee multi colors")
                    .font(.title)
                    .fontWeight(.bold)
            })
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}


struct TextShimmer: View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View {
        ZStack{
            Text(text)
                .font(.system(size: 45))
                .fontWeight(.bold)
                .foregroundColor(Color.white.opacity(0.25))
            
            // MultiColor text
            
            HStack(spacing: 0){
                ForEach(0..<text.count, id: \.self) { index in
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
            }
            // Masking for shimmer effect
            .mask(
                Rectangle()
                    //for some more nice eeffect were going to use gradient...
                    .fill(
                        //You can use any Color here
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .padding(20)
                    
                    //Moving viwe continously...
                    .offset(x: -250)
                    .offset(x: animation ? 500 : 0)
                
            )
            .onAppear(perform: {
                withAnimation(
                    Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                        animation.toggle()
                }
            })
        }
        
    }
    
    
    //Random color
    //its your wish you can change anything here
    //or you can also use Array of colors to pick random one
    
    func randomColor() -> Color {
        let color = UIColor(red: CGFloat.random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
}
