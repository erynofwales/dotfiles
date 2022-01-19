//
//  main.swift
//  ShellLog
//
//  Created by Eryn Wells on 1/18/22.
//

import ArgumentParser
import OSLog

enum Level {
    case Debug
    case Info
    case Warn
    case Error
}

extension Level: ExpressibleByArgument {
    init?(argument: String) {
        switch (argument) {
        case "debug":
            self = .Debug
        case "info":
            self = .Info
        case "warn":
            self = .Warn
        case "error":
            self = .Error
        default:
            return nil
        }
    }
}

struct ShellLog: ParsableCommand {

    @Option(name: .shortAndLong, help: "The log level")
    var level: Level?

    @Argument() var message: String

    func run() throws {
        let log = Logger(subsystem: "me.erynwells.shell", category: "Shell")
        switch level {
        case .some(.Debug):
            log.debug("\(message, privacy: .public)")
        case .none, .some(.Info):
            log.info("\(message, privacy: .public)")
        case .some(.Warn):
            log.warning("\(message, privacy: .public)")
        case .some(.Error):
            log.error("\(message, privacy: .public)")
        }
    }
}

ShellLog.main()
