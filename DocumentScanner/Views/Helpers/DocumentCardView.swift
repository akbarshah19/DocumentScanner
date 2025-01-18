//
//  DocumentCardView.swift
//  DocumentScanner
//
//  Created by Akbarshah Jumanazarov on 1/18/25.
//

import SwiftUI

struct DocumentCardView: View {
    
    var document: Document
    var animationID: Namespace.ID
    
    @State private var downsizedImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let firstPage = document.pages?.sorted(by: { $0.pageIndex < $1.pageIndex }).first {
                
            }
        }
    }
}
