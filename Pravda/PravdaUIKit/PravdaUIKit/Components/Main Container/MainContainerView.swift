//
//  MainContainerView.swift
//  PravdaUIKit
//
//  Created by Матвеенко Дмитрий Владимирович on 08.06.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol MainContainerViewProtocol: UIView {
	func add(asChild childView: UIView)
}

final class MainContainerView: UIView {

	// MARK: Life Cycle

	init() {
		super.init(frame: .zero)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Setup Protocol

extension MainContainerView: MainContainerViewProtocol {
	func add(asChild childView: UIView) {
		self.addSubview(childView)
		childView.frame = self.bounds
		childView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}
}