//
//  CategoryTableViewCell.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 20/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    
    weak var categoriesViewModel: CategoryTableViewCellViewModelType? {
        willSet(categoriesViewModel) {
            guard let categoriesViewModel = categoriesViewModel else { return }
            
            categoryLabel.text = categoriesViewModel.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}