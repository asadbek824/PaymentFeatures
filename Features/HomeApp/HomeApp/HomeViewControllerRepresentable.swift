//
//  HomeViewControllerRepresentable.swift
//  HomeApp
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import SwiftUI
import Home

struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = HomeAssemblyImpl.assemble()
        return UINavigationController(rootViewController: vc)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
}
