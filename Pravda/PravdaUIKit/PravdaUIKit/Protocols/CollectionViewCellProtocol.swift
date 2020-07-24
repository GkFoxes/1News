//
//  CollectionViewCellProtocol.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 24.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol CollectionViewCellProtocol: UICollectionViewCell {
	static var reuseIdentifer: String { get }

	static func getEstimatedHeight() -> CGFloat
}
