

import Foundation

struct PokemonModel: Codable{
    
    let sprites: Sprites
}

class Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
         case frontDefault = "front_default"
     }
    
    init(frontDefault: String) {
        self.frontDefault = frontDefault
    }
}
