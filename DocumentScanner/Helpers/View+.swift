//
//  View+.swift
//  DocumentScanner
//
//  Created by Akbarshah Jumanazarov on 1/14/25.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func VSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func loadingScreen(status: Binding<Bool>) -> some View {
        self
            .overlay {
                if status.wrappedValue {
                    ZStack {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .frame(maxWidth: 40, maxHeight: 40)
                            .background(.bar, in: .rect(cornerRadius: 10))
                    }
                }
            }
            .animation(snappy, value: status.wrappedValue)
    }
    
    var snappy: Animation {
        .snappy(duration: 0.25, extraBounce: 0)
    }
}

