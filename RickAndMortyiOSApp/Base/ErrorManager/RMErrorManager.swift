//
//  ErrorManager.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

// MARK: RMError enum

enum RMError: Error {
    case serviceError(message: String)
    case decodeError(forDecodable: String)
    case parseError(message: String)
    case unknownError(message: String)
}

// MARK: RMErrorManager class

class RMErrorManager: ObservableObject {
    @Published var errorMessage: String? = nil
    
    /// Method that set errorMessage to show error snackbar
    /// - Parameter message: error message
    func showError(_ message: String) {
        errorMessage = message
    }
    
    /// Method that set errorMessage depending on the received error, to show error snackbar
    /// - Parameter message: RMError object
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
    
    /// Method that clear errorMessage and hide snackbar
    func clearError() {
        errorMessage = nil
    }
}

// MARK: RMErrorSnackbar component view

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

// MARK: RMErrorHandler view modifier

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
