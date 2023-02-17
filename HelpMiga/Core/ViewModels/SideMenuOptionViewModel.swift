//
//  SideMenuOptionViewModel.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 03/02/23.
//

import Foundation

enum SideMenuOptionViewModel: Int, CaseIterable, Identifiable {
    
    case helpRequests
    case settings
    case messages
    
    var title: String {
        switch self {
        case .helpRequests: return "Seus Chamados"
        case .settings: return "Configurações"
        case .messages: return "Mensagens"
        }
    }
    var imageName: String {
        switch self {
        case .helpRequests: return "list.bullet.rectangle"
        case .settings: return "gear"
        case .messages: return "bubble.left"
        }
    }
    var id: Int {
        return self.rawValue
    }
}

