import Fluent
import Vapor

//struct for creating account without ID
struct postAccount: Content {
    var email: String
    var fullName: String
    var password: String
    var type: String
}

//Struct for login request
struct Login: Content {
    var email: String
    var password: String
}

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("accounts") { req -> EventLoopFuture<[Account]> in
        Account.query(on: req.db).all()
    }
    
    app.get("login") { req -> String in
        let login = try req.content.decode(Login.self)
        //if the values returned here equal the values stored in the database for that email address, return the ID associated with the account
        return "hi"
    }
    
    app.post("createaccount") { req -> String in
        //attempt to decode the returned data
        let account = try req.content.decode(postAccount.self)
        
        //first check to see if an account with the requested credentials exists
        Account.query(on: req.db).filter(\.$email == account.email).first()
            

        
        //generate a unique identifier for the account that can be used as a password
        let id = UUID()
        let finalAccount = Account(id: id, fullName: account.fullName, email: account.email, password: account.password, type: account.type)
        
        //save the account to ze database
        finalAccount.save(on: req.db)
        //Print to the console and perform the action of creating the account
        print("Creating account with the name: ", account.fullName)
        
        return finalAccount.id!.uuidString
    }

    try app.register(collection: TodoController())
}
