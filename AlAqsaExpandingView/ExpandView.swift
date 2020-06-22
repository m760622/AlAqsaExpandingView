//
//  ExpandView.swift
//  AlAqsaExpandingView
// m7606225@gmail.com
//  Created by Mohammed Abunada on 2020-06-22.
//  Copyright © 2020 NMDS. All rights reserved.
// https://github.com/m760622

import SwiftUI

struct ExpandView : View {
    @State var dragValue = CGSize.zero
    @Binding var isExpand : Bool
    @Binding var activeId : UUID
    var aqsaArray : Item
    var body : some View {
        ZStack(alignment: .top) {
            Image(aqsaArray.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .onTapGesture {
                    self.isExpand = true
                    self.activeId = self.aqsaArray.id
            }
            .opacity(self.activeId == aqsaArray.id ? 0 : 1)
            
            // Title and subtitle
            HStack {
                Text(aqsaArray.subTitle)
                    .foregroundColor(Color(.systemGray2))
                    .fontWeight(.semibold)
                    .frame(width: 30, height: 30)
                    .background(Color(.black).opacity(0.5))
                    .clipShape(Circle())
                Text(aqsaArray.title)
                    .font(.system(.headline))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: ScreenSizeEx.width - 90)
                    .background(Color(.black).opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }//HStack
                .offset(x: 0, y: 5)
                .opacity(self.activeId == aqsaArray.id ? 0 : 1)
            
            // Over lay content When click on any item
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        Image(aqsaArray.image)
                            .resizable()
                            .frame(height: ScreenSizeEx.height * 0.55)
                        Text(aqsaArray.subTitle)
                            .foregroundColor(Color(.black))
                            .fontWeight(.semibold)
                            .frame(width: 30, height: 30)
                            .background(Color(.white).opacity(0.7))
                            .clipShape(Circle())
                            .offset(x: -ScreenSizeEx.width * 0.42, y: -ScreenSizeEx.height * 0.51)
                        
                        Text(aqsaArray.title)
                            .foregroundColor(.black)
                            .font(.system(.headline))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(width: ScreenSizeEx.width - 60)
                            .background(Color(.white).opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius:  5))
                            .padding(.top, aqsaArray.title.count < 37 ? -65 : -90)
                        
                        Text(aqsaArray.content)
                            .foregroundColor(.gray)
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(.bold)
                            //                            .multilineTextAlignment(.natural)
                            .lineSpacing(15)
                            .padding()
                    }//VStack
                }//ScrollView
                    .edgesIgnoringSafeArea(.all)
                
                // Close button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isExpand = false
                            self.activeId = UUID()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.white.opacity(0.9))
                        }
                        .frame(width: 30, height: 30)
                        .background(
                            Circle().foregroundColor(Color.black.opacity(0.4))
                        )
                    }//HStack
                        .padding(.top, 30)
                    Spacer()
                }//VStack
                    .padding()
            }.opacity(self.activeId == aqsaArray.id ? 1 : 0)
                .gesture(
                    self.activeId == aqsaArray.id ?
                        DragGesture().onChanged({ value in
                            guard value.translation.height < 200 else {return}
                            if value.translation.height > 400 {
                                self.isExpand = false
                                self.activeId = UUID()
                                self.dragValue = .zero
                            } else {
                                self.dragValue = value.translation
                            }
                        }).onEnded({ value in
                            if value.translation.height > 300 {
                                self.isExpand = false
                                self.activeId = UUID()
                            }
                            self.dragValue = .zero
                        }) : nil
            ).scaleEffect(1 - (self.dragValue.height / 1000))
            
        }// ZStack
            .frame(height: self.activeId == self.aqsaArray.id ? ScreenSizeEx.height : ScreenSizeEx.height * 0.45)
            .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.6))
            .edgesIgnoringSafeArea(.all)
    }//body
}//ExpandView

