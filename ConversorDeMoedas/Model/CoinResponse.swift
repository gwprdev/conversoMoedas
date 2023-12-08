//
//  CoinResponse.swift
//  ConversorDeMoedas
//
//  Created by Gilvan Wemerson on 12/11/23.
//

import Foundation

typealias ExchangeCoins = [String : Coin]

struct CoinResponse: Decodable{
    var coins:[Coin]
}

class Coin: Codable {
    let code: String?, codein: String?, name: String?, high: String
    let low, varBid, pctChange, buyValue, sellValue: String
    
    enum CodingKeys: String, CodingKey {
        case code, codein, name, high, low, varBid, pctChange
        case buyValue = "bid"
        case sellValue = "ask"
    }
    
    required  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.codein = try container.decodeIfPresent(String.self, forKey: .codein)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.high = try container.decode(String.self, forKey: .high)
        self.low = try container.decode(String.self, forKey: .low)
        self.varBid = try container.decode(String.self, forKey: .varBid)
        self.pctChange = try container.decode(String.self, forKey: .pctChange)
        self.buyValue = try container.decode(String.self, forKey: .buyValue)
        self.sellValue = try container.decode(String.self, forKey: .sellValue)
        
    }
}


class ErrorResponse: Codable {
    let status: Int
    let code: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status, code, message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try values.decode(Int.self, forKey: .status)
        self.code = try values.decode(String.self, forKey: .code)
        self.message = try values.decode(String.self, forKey: .message)
    }
}
