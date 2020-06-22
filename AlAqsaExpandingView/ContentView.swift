//
//  ContentView.swift
//  AlAqsaExpandingView
// m7606225@gmail.com
//  Created by Mohammed Abunada on 2020-06-22.
//  Copyright © 2020 NMDS. All rights reserved.
// https://github.com/m760622

import SwiftUI

struct ContentView: View {
    @State var isExpand = false
    @State var activeId = UUID()
    @ObservedObject var aqsaVM:AqsaViewModel = AqsaViewModel()
    
    var body: some View {
        let aqsaDB = aqsaVM.aqsaArray
        
        return ZStack {
            Color(self.isExpand ? .systemGray2 : .white).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Al-Aqsa Mosque in Palestine")
                        .font(.system(.body, design: .monospaced))
                        .fontWeight(.heavy)
                    Spacer()
                }//HStack
                Text("MONDAY, Juni 22 - 2020")
                    .font(.body)
                    .foregroundColor(Color(.systemGray))
            }//VStack
                .offset(y: -ScreenSizeEx.height * 0.4)
                .padding()
                .opacity(self.isExpand ? 0 : 1)
            
            ScrollView(.vertical, showsIndicators: true) {
                // Let's seperate each item by using their UUID
                VStack(spacing: 30) {
                    ForEach(aqsaDB) { item in
                        GeometryReader { reader in
                            ExpandView(isExpand: self.$isExpand, activeId: self.$activeId, aqsaArray: item)
                                .offset(y: self.activeId == item.id ? -reader.frame(in: .global).minY : 0)
                                // If not current card and expand mode is true, hide it
                                .opacity(self.activeId != item.id && self.isExpand ? 0 : 1)
                        }.frame(height: ScreenSizeEx.height * 0.45)
                            .frame(maxWidth: self.isExpand ? ScreenSizeEx.width : ScreenSizeEx.width * 0.95)
                    }
                }//VStack
            }//ScrollView
                .offset( y: self.isExpand ?  0 : 70)
        }//ZStack
    }//body
}//ContentView

struct ExpandingView_Previews : PreviewProvider {
    static var previews : some View {
        ContentView()
    }
}

// Get Screen size
struct ScreenSizeEx {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}
