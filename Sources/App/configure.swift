import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: "localhost",
        port: 5432,
        username: "vapor",
        password: "vapor",
        database: "penpals"
    ), as: .psql)

    app.migrations.add(CreateTodo())
    
    app.http.server.configuration.hostname = "0.0.0.0"
    //app.http.server.configuration.port = 8000
    
    // register routes
    try routes(app)
}
