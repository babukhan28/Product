//
//  ProductListTableViewCell.swift
//  Product
//
//  Created by Rajni on 12/05/23.
//

import UIKit
import SnapKit

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBGProduct: UIView!
    
    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var btnRate: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCateogry: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var product: ProductModel? {
        didSet { // Property Observer 
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        viewBGProduct.clipsToBounds = false
        viewBGProduct.layer.cornerRadius = 15
        viewBGProduct.backgroundColor = .systemGray6
        
        imgViewProduct.layer.cornerRadius = 10
    }
    
    private func productDetailConfiguration() {
        guard let product else { return }
        
        imgViewProduct.setImage(urlString: product.image)
        
        lblTitle.text = product.title
        lblCateogry.text = product.category.rawValue
        lblDescription.text = product.description
        lblPrice.text = "₹\(product.price)"
        btnRate.setTitle("\(product.rating.rate)", for: .normal)
    }
}
