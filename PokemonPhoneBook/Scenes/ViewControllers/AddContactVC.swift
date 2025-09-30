
import Foundation
import UIKit
import SnapKit
import CoreData

class AddContactVC:UIViewController{
    let addView = AddContactView()
    let pokemonSpriteFetcher = PokemonSpriteFetch()
    
    var container: NSPersistentContainer!
    weak var delegate: AddContactDelegate?
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addView.randomIMG.image = nil
        addView.nameTextField.text = ""
        addView.phoneNumberTextField.text = ""
    }
    private func configureView(){
        view.addSubview(addView)
        
        addView.randomImgButton.addTarget(self, action: #selector(randomImgButtonTapped), for: .touchUpInside)
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
        
        createData(name: addView.nameTextField.text!, phoneNumber: addView.phoneNumberTextField.text!, image: (addView.randomIMG.image?.pngData())!)
        delegate?.didAddNewContact()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func randomImgButtonTapped(){
        print("buttonTap")
        pokemonSpriteFetcher.fetchPokemonSprite{
            [weak self] image in DispatchQueue.main.async{
                self?.addView.randomIMG.image = image
            }
        }
    }
    
    func createData(name: String, phoneNumber: String, image: Data){
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else {return}
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: "name")
        newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
        newPhoneBook.setValue(image, forKey: "image")
        
        do{
            try self.container.viewContext.save()
            print("저장 성공")
        }catch{
            print("저장 실패")
        }
    }
    
}


#Preview{
    AddContactVC()
}
