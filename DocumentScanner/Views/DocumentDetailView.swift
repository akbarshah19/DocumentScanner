//
//  DocumentDetailView.swift
//  DocumentScanner
//
//  Created by Akbarshah Jumanazarov on 1/21/25.
//

import SwiftUI

struct DocumentDetailView: View {
    
    var document: Document
    
    var body: some View {
        if let pages = document.pages?.sorted(by: { $0.pageIndex < $1.pageIndex }) {
            VStack(spacing: 10) {
                HeaderView()
                    .padding([.horizontal, .top], 15)
                
                TabView {
                    ForEach(pages) { page in
                        if let image = UIImage(data: page.pageData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .tabViewStyle(.page)
                
                FooterView()
            }
            .background(.black)
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        Text(document.name)
            .font(.callout)
            .foregroundStyle(.white)
            .hSpacing(.center)
            .overlay(alignment: .trailing) {
                Button {
                    //
                } label: {
                    Image(systemName: document.isLocked ? "lock.fill" : "lock.open.fill")
                }
            }
        
    }
    
    @ViewBuilder
    private func FooterView() -> some View {
        HStack {
            Button {
                //
            } label: {
                Image(systemName: "square.and.arrow.up.fill")
                    .font(.title3)
                    .foregroundStyle(.red)
            }
            
            Spacer(minLength: 0)
            
            Button {
                //
            } label: {
                Image(systemName: "trash.fill")
                    .font(.title3)
                    .foregroundStyle(.red)
            }
        }
        .padding([.horizontal, .top], 15)
    }
}
