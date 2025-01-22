//
//  DocumentDetailView.swift
//  DocumentScanner
//
//  Created by Akbarshah Jumanazarov on 1/21/25.
//

import SwiftUI
import PDFKit

struct DocumentDetailView: View {
    
    var document: Document
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
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
            Button(action: createAndShareDocument) {
                Image(systemName: "square.and.arrow.up.fill")
                    .font(.title3)
                    .foregroundStyle(.red)
            }
            
            Spacer(minLength: 0)
            
            Button {
                dismiss()
                Task { @MainActor in
                    try? await Task.sleep(for: .seconds(0.5))
                    modelContext.delete(document)
                    try? modelContext.save()
                }
            } label: {
                Image(systemName: "trash.fill")
                    .font(.title3)
                    .foregroundStyle(.red)
            }
        }
        .padding([.horizontal, .top], 15)
    }
    
    private func createAndShareDocument() {
        guard let pages = document.pages?.sorted(by: { $0.pageIndex < $1.pageIndex }) else {
            return
        }
        
        let pdfDoc = PDFDocument()
        for index in pages.indices {
            if let pageImage = UIImage(data: pages[index].pageData),
               let pdfPage = PDFPage(image: pageImage) {
                pdfDoc.insert(pdfPage, at: index)
            }
        }
        
        var pdfURL = FileManager.default.temporaryDirectory
        let fileName = "\(document.name).pdf"
        pdfURL.append(path: fileName)
        
        if pdfDoc.write(to: pdfURL) {
            
        }
    }
}
