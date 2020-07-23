//
//  SectionsTabBarController.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 27.05.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

public protocol SafariNewsTappedProtocol: UIViewController {
	func safariNewsTapped()
}

protocol SectionsTabBarControllerProtocol: UIViewController {
	func changeInterfaceToRegularAppearance()
	func changeInterfaceToCompactAppearance(with displayMode: UISplitViewController.DisplayMode?)
}

final class SectionsTabBarController: UITabBarController {

	// MARK: Properties

	/// When Safari news tapped from second or third sections, changes in selectedIndex
	/// default = false
	private var isSafariNewsTapped = false

	// MARK: View Controllers

	// Sections Tab have first, second, third in Compact interface.
	// But in Regular interface Tab have only second, third.
	private let firstSectionViewController: UIViewController
	private let secondSectionViewController: UIViewController
	private let thirdSectionViewController: UIViewController

	// MARK: Life Cycle

	init(
		firstSectionViewController: UIViewController,
		secondSectionViewController: UIViewController,
		thirdSectionViewController: UIViewController
	) {
		self.firstSectionViewController = firstSectionViewController
		self.secondSectionViewController = secondSectionViewController
		self.thirdSectionViewController = thirdSectionViewController

		super.init(nibName: nil, bundle: nil)

		initialInterface()
	}

	override func loadView() {
		super.loadView()

		setupDesignAppearances()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Changes From Sections

extension SectionsTabBarController: SafariNewsTappedProtocol {
	func safariNewsTapped() {
		isSafariNewsTapped = true
	}
}

// MARK: Changes From MainContainer

extension SectionsTabBarController: SectionsTabBarControllerProtocol {
	func changeInterfaceToRegularAppearance() {
		isSafariNewsTapped = false

		self.viewControllers?.removeFirst()
	}

	func changeInterfaceToCompactAppearance(with displayMode: UISplitViewController.DisplayMode?) {
		var selectedIndex = self.selectedIndex

		if isSafariNewsTapped == true {
			// If change size classes when read news in Safari, show index where tap came from
			isSafariNewsTapped = false
			selectedIndex += 1
		} else {
			if displayMode == .primaryHidden || displayMode == .allVisible || displayMode == nil {
				//If Master view hidden or first section in read, show it in compact tab
				selectedIndex = 0
			} else {
				selectedIndex += 1
			}
		}

		self.viewControllers?.insert(firstSectionViewController, at: 0)
		self.selectedIndex = selectedIndex
	}
}

// MARK: Setup Interface

private extension SectionsTabBarController {
	func initialInterface() {
		switch getHorizontalAndVerticalSizeClasses() {
		case (.regular, .regular):
			setupRegularInterface()
		default:
			setupCompactInterface()
		}
	}

	func setupRegularInterface() {
		// In regular always two sections in tab
		self.viewControllers = [
			secondSectionViewController,
			thirdSectionViewController
		]
	}

	func setupCompactInterface() {
		// In compact always three sections in tab
		self.viewControllers = [
			firstSectionViewController,
			secondSectionViewController,
			thirdSectionViewController
		]
	}

	func setupDesignAppearances() {
		let appearance = UITabBarAppearance()
		let selectedColor = UIColor.systemPink

		appearance.backgroundColor = .systemBackground
		appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
		appearance.inlineLayoutAppearance.selected.iconColor = selectedColor
		appearance.compactInlineLayoutAppearance.selected.iconColor = selectedColor

		let selectedTitleTextAttributes = [
			NSAttributedString.Key.foregroundColor: selectedColor
		]

		appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
		appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
		appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes

		tabBar.standardAppearance = appearance
	}
}