//
//  ErrorManager.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI
import Combine

class RMErrorManager: ObservableObject {
    @Published var errorMessage: String? = nil
    
    func showError(_ message: String) {
        errorMessage = message
    }
    
    func showError(from error: RMError) {
        switch error {
        case .serviceError(let message):
            errorMessage = message
        case .decodeError(let forDecodable):
            errorMessage = forDecodable
        case .parseError(let message):
            errorMessage = message
        case .unknownError(let message):
            errorMessage = message
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
}

struct RMErrorSnackbar: View {
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

struct RMErrorHandler: ViewModifier {
    @StateObject var errorManager: RMErrorManager = RMErrorManager()

    func body(content: Content) -> some View {
        ZStack {
            content
            if let message = errorManager.errorMessage {
                VStack {
                    Spacer()
                    RMErrorSnackbar(message: message)
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
    func handleError(with errorManager: RMErrorManager) -> some View {
        self.modifier(RMErrorHandler(errorManager: errorManager))
    }
}
