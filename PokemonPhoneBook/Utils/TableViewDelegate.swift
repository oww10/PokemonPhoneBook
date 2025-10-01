
import Foundation

protocol PhoneBookTableViewDelegate: AnyObject {
    func phoneBookTableView(_ tableView: PhoneBookTableView, didSelectRowAt indexPath: IndexPath)
}
