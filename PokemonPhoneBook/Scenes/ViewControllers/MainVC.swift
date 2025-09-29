
import Foundation
import UIKit

class MainVC: UIViewController{
    let phoneTableView = PhoneBookTableView()
    let addContactVC = AddContactVC()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "친구 목록"
        
        setupNavigationBar()
        configureView()
        setupUI()
        
    }
    
    private func setupNavigationBar(){
        let addButton = UIBarButtonItem(
            title: "추가", style: .plain, target: self, action: #selector(addButtonTapped)
        )
        self.navigationItem.rightBarButtonItem = addButton
    }
    @objc func addButtonTapped(){
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    func configureView(){
        self.view.addSubview(phoneTableView)
    }
    func setupUI(){
        phoneTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
