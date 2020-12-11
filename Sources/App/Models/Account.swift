//
//  File.swift
//  
//
//  Created by Joseph Simeone on 12/6/20.
//

import Fluent
import Vapor

final class Account: Model, Content {
    typealias IDValue = String?
    
    
    //Name of table or collection
    static let schema = "accounts"
    
    //Unique identifier for this account
    @ID(key: "email")
    var email: String?
    
    //Account holder's details
    @Field(key: "fullName")
    var fullName: String
    @Field(key: "id")
    var id: UUID
    @Field(key: "password")
    var password: String
    @Field(key: "type")
    var type: String
    
    //creation method for new, empty account
    init() { }
    
    //Struct to get the ID out
    struct idOut: Content {
        let id: UUID
    }
    
    //Struct to get parameters to create new account
    struct postAccount: Content {
        var email: String
        var fullName: String
        var password: String
        var type: String
    }
    
    //struct that returns the password and ID for a given account in order for it to be checked against the one entered
    struct loginCheck: Content {
        var password: String
        var id: UUID
    }
    
    //Constructor for new account with all properties set
    init(id: UUID?, fullName: String, email: String, password: String, type: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.password = password
        self.type = type
    }
}

struct AccountController {
    //Create new account. NEED TO CHECK IF AN ACCOUNT ALREADY EXISTS AND THROW ERROR IF SO
    func newAccount(req: Request) throws -> EventLoopFuture<Account.idOut> {
        let input = try req.content.decode(Account.postAccount.self)
        let id = UUID()
        let account = Account(id: id, fullName: input.fullName, email: input.email, password: input.password, type: input.type)
        return account.save(on: req.db)
            .map { Account.idOut(id: account.id!.uuidString)}
    }
    
    func login(req: Request) throws -> EventLoopFuture<Account.loginCheck> {
        guard let email = req.parameters.get("email", as: String.self) else {
            throw Abort(.badRequest)
        }
        return Account.find(email, on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { Account.loginCheck(password: $0.password, id: $0.id!)}
    }
}
