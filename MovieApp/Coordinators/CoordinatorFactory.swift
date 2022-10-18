//
//  CoordinatorFactory.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import UIKit

class CoordinatorFactory {
    enum CoordinatorClass: String {
        case memberGetMember = "MemberGetMemberCoordinator"
    }
    
    private var presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func createFrom(coordinatorName: String) -> DelegatableCoordinatorProtocol? {
        switch CoordinatorClass(rawValue: getCoordinatorName(coordinatorName)) {
        case .memberGetMember:
            return buildMemberGetMemberCoordinator()
        case .none:
            return nil
        }
    }
    
    private func getCoordinatorName(_ coordinatorName: String) -> String {
        if !coordinatorName.contains(":") {
            return coordinatorName
        }
        
        if coordinatorName.contains("?") {
            return coordinatorName.subString(startIndex: coordinatorName.index(ofAccessibilityElement: ":"),
                                              endIndex: coordinatorName.index(ofAccessibilityElement: "?"))
        }
        
        return coordinatorName.components(separatedBy: ":")[1]
    }
    
    private func buildMemberGetMemberCoordinator() -> DelegatableCoordinatorProtocol {
        return MemberGetMemberCoordinator(presenter: presenter) as DelegatableCoordinatorProtocol
    }
}

