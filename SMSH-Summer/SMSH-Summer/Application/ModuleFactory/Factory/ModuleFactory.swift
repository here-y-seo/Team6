//
//  ModuleFactory.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/27.
//

import Foundation
import UIKit

protocol ModuleFactoryProtocol {
    
    // MARK: - Auth
    func VC() -> ViewController
}

class ModuleFactory: ModuleFactoryProtocol {

    static func resolve() -> ModuleFactory {
        return ModuleFactory()
    }
  
    // MARK: - Main
    func VC() -> ViewController {
        let vc = ViewController.controllerFromStoryboard(.main)
        return vc
    }
}
