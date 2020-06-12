//
//  FavoritesViewController.swift
//  Pravda-MVC
//
//  Created by Матвеенко Дмитрий on 19.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

import PravdaUIKit
import SafariServices

final class FavoritesViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = .green
		self.navigationItem.title = StringConstants.favoritesTitle
	}
}

extension FavoritesViewController: SFSafariViewControllerDelegate {
	private func openUrl() {
		if let url = URL(string: "https://stackoverflow.com/questions") {
			if  UIApplication.shared.canOpenURL(url) {
				let svc = SFSafariViewController(url: url)
				self.present(svc, animated: true, completion: {
					print("keka")
				})

				guard let rootViewController = getSectionsTabBarController() else { return }
				rootViewController.safariNewsTapped()
			} else {
				let alert = UIAlertController(title: "Can not open this website",
											  message: "Please check the existence of the website",
											  preferredStyle: .alert)

				alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
											  style: .default,
											  handler: { _ in
												NSLog("The \"OK\" alert occured.")
				}))

				self.present(alert, animated: true, completion: nil)
			}
		}
	}
}