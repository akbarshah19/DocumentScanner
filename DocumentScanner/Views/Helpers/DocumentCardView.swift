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
                GeometryReader {
                    let size = $0.size
                    
                    if let downsizedImage {
                        Image(uiImage: downsizedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: size.width, height: size.height)
                    } else {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .task(priority: .high) {
                                guard let image = UIImage(data: firstPage.pageData) else { return }
                                let aspectSize = image.size.aspectFit(.init(width: 150, height: 150))
                                let renderer = UIGraphicsImageRenderer(size: aspectSize)
                                let resizedImage = renderer.image { context in
                                    image.draw(in: CGRect(origin: .zero, size: aspectSize))
                                }
                                
                                await MainActor.run {
                                    downsizedImage = resizedImage
                                }
                            }
                    }
                }
                .frame(height: 150)
                .clipShape(.rect(cornerRadius: 15))
                .matchedGeometryEffect(id: document.uniqueViewID, in: animationID)
            }
            
            Text(document.name)
                .font(.callout)
                .lineLimit(1)
                .padding(.top, 10)
            
            Text(document.createdAt.formatted(date: .numeric, time: .omitted))
                .font(.caption2)
                .foregroundStyle(.gray)
        }
    }
}
