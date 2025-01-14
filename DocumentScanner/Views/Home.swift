//
//  Home.swift
//  DocumentScanner
//
//  Created by Akbarshah Jumanazarov on 1/14/25.
//

import SwiftUI
import SwiftData

struct Home: View {
    
    @State private var showScannerView: Bool = false
    @Query(sort: [.init(\Document.createdAt, order: .reverse)], animation: .snappy(duration: 0.25, extraBounce: 0)) private var documents: [Document]
    private let columns: [GridItem] = Array(repeating: GridItem(spacing: 10), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(documents) { document in
                        
                    }
                }
            }
            .navigationTitle("Documents")
            .safeAreaInset(edge: .bottom, content: CreateButton)
            .fullScreenCover(isPresented: $showScannerView) {
                ScannerView { error in
                    
                } didCancel: {
                    showScannerView = false
                } didFinish: { scan in
                    showScannerView = false
                }
                .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    private func CreateButton() -> some View {
        Button {
            showScannerView.toggle()
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "document.viewfinder.fill")
                    .font(.title3)
                
                Text("Scan Documents")
            }
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(.purple.gradient, in: .capsule)
        }
        .hSpacing(.center)
        .padding(.vertical, 10)
        .background {
            Rectangle()
                .fill(.background)
                .mask {
                    Rectangle()
                        .fill(.linearGradient(
                            colors: [
                                .white.opacity(0),
                                .white.opacity(0.5),
                                .white,
                                .white
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                }
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
