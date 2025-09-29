//
//  AddContactVC.swift
//  PokemonPhoneBook
//
//  Created by oww on 9/29/25.
//

import Foundation
import UIKit
import SnapKit

class AddContactVC:UIViewController{
    
    let addView = AddContactView()
    
    override func loadView() {
        super.loadView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "연락처 추가"
        setupNavigationBar()
        configureView()
        setupUI()
    }
    
    private func configureView(){
        view.addSubview(addView)
    }
    
    private func setupUI(){
        addView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar(){
        let saveButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonTapped(){
        
    }
}
#Preview{
    AddContactVC()
}
