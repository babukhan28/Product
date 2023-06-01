//
//  ProductListViewController.swift
//  Product
//
//  Created by Rajni on 12/05/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tblViewProduct: UITableView!
    
    private var productViewModel = ProductViewModel()
    let cellIdentifier = "ProductListTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension ProductListViewController {
    
    func configuration() {
        tblViewProduct.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        initViewModel()
        observeEvent() 
    }
    
    func initViewModel() {
        productViewModel.fetchProducts()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tblViewProduct.reloadData()
        }
    }
    
    //Data-Binding Oserver Event
    func observeEvent () {
        productViewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            
            switch event {
            case .loading:
                break
            case .stopLoading:
                break
            case .dataLoaded:
                self.reloadData()
                break
            case .error(_):
                break
            case .newProductAdded(productAdded: let newProduct):
                print(newProduct)
            }
        }
    }
}


extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductListTableViewCell else {
            return UITableViewCell()
        }
        cell.product = productViewModel.products[indexPath.row]
        return cell
    }
    
    
}
