//
//  HomeViewModel.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 05/02/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class HomeViewModel: ObservableObject {
    
    @Published var helpers = [User]()
    
    init() {
        
        fetchHelpers()
    }
    
    func fetchHelpers() {
        Firestore.firestore().collection("users")
            .whereField("accountMode",isEqualTo: AccountMode.helper.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let helpers = documents.compactMap({ try? $0.data(as: User.self)})
                self.helpers = helpers
        }
    }
}

