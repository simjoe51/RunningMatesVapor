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
    @Field(key: "email")
    var email: String
    @Field(key: "password")
    var password: String
    @Field(key: "type")
    var type: String
    
    //struct for getting ID out
    struct IDOUT: Content {
        let id: UUID
    }
    
    //creation method for new, empty account
    init() { }
    
    //Constructor for new account with all properties set
    init(id: UUID?, fullName: String, email: String, password: String, type: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.password = password
        self.type = type
    }
}
