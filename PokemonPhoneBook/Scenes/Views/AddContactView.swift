
import Foundation
import UIKit
import SnapKit

class AddContactView: UIView{
    
    var randomIMG: UIImageView = {
        let img = UIImageView()
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.gray.cgColor
        img.layer.cornerRadius = 100
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    var randomImgButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
        return button
    }()
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews(){
        [randomIMG,randomImgButton,nameTextField,phoneNumberTextField].forEach{addSubview($0)}
    }
    private func setupUI(){
        randomIMG.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.width.height.equalTo(200)
            
        }
        randomImgButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(randomIMG.snp.bottom).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(30)
            
        }
        nameTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(randomImgButton.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        phoneNumberTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
#Preview{
    AddContactVC()
}
