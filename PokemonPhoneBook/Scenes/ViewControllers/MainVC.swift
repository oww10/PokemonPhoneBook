
import Foundation
import UIKit
import CoreData
import SnapKit


protocol AddContactDelegate: AnyObject {
    func didAddNewContact()
}

class MainVC: UIViewController,AddContactDelegate{
    func didAddNewContact() {
        readAllData()
    }
    let phoneTableView = PhoneBookTableView()
    
    var container: NSPersistentContainer!
    
    var phoneBookEntries: [PhoneBookCell.PhoneDatas] = [] {
        didSet {
            phoneTableView.phoneBookEntries = phoneBookEntries
        }
    }
    
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        readAllData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readAllData()
    }
    private func setupNavigationBar(){
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        let resetButton = UIBarButtonItem(title: "초기화", style: .plain, target: self, action: #selector(resetButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = resetButton
    }
    
    
    @objc func resetButtonTapped(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PhoneBook.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do{
            try container.viewContext.execute(deleteRequest)
            try container.viewContext.save()
            
            self.phoneBookEntries.removeAll()
        } catch{
            print("데이터 삭제 실패")
        }
    }
    
    
    @objc func addButtonTapped(){
        let addContactVC = AddContactVC()
        addContactVC.container = self.container
        addContactVC.delegate = self
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
    
    func readAllData() {
        do {
            self.phoneBookEntries.removeAll()
            
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest()) as [PhoneBook]
            
            for phonebook in phoneBooks {
                if let name = phonebook.name,
                   let phoneNumber = phonebook.phoneNumber {
                    let image = phonebook.image
                    
                    let newEntry = PhoneBookCell.PhoneDatas(name: name, phone: phoneNumber, image: image)
                    self.phoneBookEntries.append(newEntry)
                }
            }
            
        } catch {
            print("데이터 읽기 실패: \(error)")
        }
    }
    

}
