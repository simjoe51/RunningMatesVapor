//
//  File.swift
//  
//
//  Created by Joseph Simeone on 12/6/20.
//

import Fluent
import Vapor

final class Account: Model, Content {
    
    //Name of table or collection
    static let schema = "accounts"
    
    //Unique identifier for this account
    @ID(key: .id)
    var id: UUID?
    
    //Account holder's details
    @Field(key: "fullName")
    var fullName: String
    @Field(key: "phoneNumber")
    var phoneNumber: String
    @Field(key: "age")
    var age: String
    @Field(key: "publicKey")
    var publicKey: String
    
    //creation method for new, empty account
    init() { }
    
    //Struct to get the ID out
    struct idOut: Content {
        let id: UUID
    }
    
    //Struct to get parameters to create new account
    struct postAccount: Content {
        var fullName: String
        var phoneNumber: String
        var age: String
        var publicKey: String
    }
    
    //Struct to check for new partners
    struct postID: Content {
        var UUID: Data
    }
    
    //struct to return partner UUID and their public key
    struct partnerOut: Content {
        var ID: UUID
        var publicKey: Data
    }
    
    //Constructor for new account with all properties set
    init(id: UUID?, fullName: String, phoneNumber: String, age: String, publicKey: String) {
        self.id = id!
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.age = age
        self.publicKey = publicKey
    }
}

struct AccountController {
    //Create new account. NEED TO CHECK IF AN ACCOUNT ALREADY EXISTS AND THROW ERROR IF SO
    func newAccount(req: Request) throws -> EventLoopFuture<Account.idOut> {
        let input = try req.content.decode(Account.postAccount.self)
        
        let id = UUID()
        let account = Account(id: id, fullName: input.fullName, phoneNumber: input.phoneNumber, age: input.age, publicKey: input.publicKey)
        return account.save(on: req.db)
            .map { Account.idOut(id: account.id!) }
        
        
    }
    
    //check whether or not someone else in the database had your ID in their partnerID column
    func checkPartners(req: Request) throws -> EventLoopFuture<Account.partnerOut> {
        let input = try req.content.decode(Account.postID.self)
        return Account.query(on: req.db)
            .filter(\.$partnerID == input.UUID).map { account in
                if account == nil {
                    return Account.partnerOut(ID: UUID("00000000-0000-0000-0000-000000000000")!, publicKey: nil)
                } else {
                    return Account.partnerOut(ID: UUID("00000000-0000-0000-0000-000000000000")!, publicKey: nil)
                }
                
            }
        
    }
    
    /*
    
    func login(req: Request) throws -> EventLoopFuture<Account.idOut?> {
        guard let email = req.parameters.get("email", as: String.self) else {
            throw Abort(.badRequest)
            print("Error decoding email")
        }
        
        guard let password = req.parameters.get("password", as: String.self) else {
            throw Abort(.badRequest)
            print("error decoding password")
        }
        
        return Account.query(on: req.db)
            .filter(\.$email == email)
            .filter(\.$password == password)
            .first().map { account in
                if account == nil {
                    return Account.idOut(id: UUID("00000000-0000-0000-0000-000000000000")!)
                } else {
                    return Account.idOut(id: (account?.id)!)
                }
            }
        
       // return accountForRequest.map {Account.idOut(id: , error: nil)}
      //  return Account.find(email, on: req.db)
        //    .unwrap(or: Abort(.notFound))
         //   .map { Account.loginCheck(password: $0.password, id: $0.id!)}
    } */
}
 
