
import Foundation
import UIKit
import CoreData
import SnapKit


protocol AddContactDelegate: AnyObject {
    func didAddNewContact()
}

class MainVC: UIViewController,AddContactDelegate, PhoneBookTableViewDelegate{
    
    func phoneBookTableView(_ tableView: PhoneBookTableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Tap")
        
        let selectedData = phoneTableView.phoneBookEntries[indexPath.row]
        let addVC = AddContactVC()
        addVC.container = self.container
        addVC.delegate = self
        
        addVC.contactEdit = selectedData
        print(selectedData.name)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
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
        
        phoneTableView.customDelegate = self
        
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
        
        if self.phoneBookEntries.isEmpty {
            let emptyAlert = UIAlertController(title: "알림", message: "삭제할 데이터가 없습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            emptyAlert.addAction(okAction)
            self.present(emptyAlert, animated: true)
            return
        }
        
        
        do{
            try container.viewContext.execute(deleteRequest)
            try container.viewContext.save()
            self.phoneBookEntries.removeAll()
            let removeAlert = UIAlertController(title: "알림", message: "데이터가 삭제되었습니다.", preferredStyle: .alert)
            removeAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(removeAlert, animated: true)
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
            
            let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
                                                
            let sortingDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortingDescriptor]
            
            let phoneBooks = try self.container.viewContext.fetch(fetchRequest) as [PhoneBook]
            
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
