//
//  ErrorManager.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI
import Combine

class ErrorManager: ObservableObject {
    @Published var errorMessage: String? = nil
    
    func showError(_ message: String) {
        errorMessage = message
    }
    
    func clearError() {
        errorMessage = nil
    }
}

struct ErrorSnackbar: View {
    let message: String
    var body: some View {
        Text(message)
            .font(.system(size: 16))
            .foregroundColor(.white)
            .padding() // Padding interno del texto
            .frame(maxWidth: UIScreen.main.bounds.width - 32, alignment: .leading)
            .background(.red)
            .cornerRadius(8)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.easeInOut, value: message)
    }
}

struct ErrorHandler: ViewModifier {
    @StateObject var errorManager: ErrorManager = ErrorManager()

    func body(content: Content) -> some View {
        ZStack {
            content
            if let message = errorManager.errorMessage {
                VStack {
                    Spacer()
                    ErrorSnackbar(message: message)
                        .padding()
                        .onTapGesture {
                            errorManager.clearError()
                        }
                }
            }
        }
        .animation(.easeInOut, value: errorManager.errorMessage)
    }
}

extension View {
    func handleError(with errorManager: ErrorManager) -> some View {
        self.modifier(ErrorHandler(errorManager: errorManager))
    }
}
