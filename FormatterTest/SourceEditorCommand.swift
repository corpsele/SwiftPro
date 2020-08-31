//
//  SourceEditorCommand.swift
//  FormatterTest
//
//  Created by eport2 on 2020/6/3.
//  Copyright © 2020 eport. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    func perform(with _: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        let path = FileManager.default.currentDirectoryPath
        print("path = \(path)")
        completionHandler(nil)
    }
}
