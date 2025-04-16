//
//  View+NavigationControllerFinder.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/10/25.
//

import UIKit
import SwiftUI

public extension View {
    func currentNavigationController(_ completion: @escaping (UINavigationController?) -> Void) -> some View {
        background(NavigationControllerFinder(completion: completion))
    }
}

public struct NavigationControllerFinder: UIViewControllerRepresentable {
    let completion: (UINavigationController?) -> Void

    public func makeUIViewController(context: Context) -> UIViewController {
        FinderViewController(completion: completion)
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }

    private class FinderViewController: UIViewController {
        let completion: (UINavigationController?) -> Void

        init(completion: @escaping (UINavigationController?) -> Void) {
            self.completion = completion
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) { fatalError() }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            completion(self.navigationController)
        }
    }
}
