//
//  PyInputHelper.swift
//  Pyto
//
//  Created by Adrian Labbe on 9/9/18.
//  Copyright © 2018 Adrian Labbé. All rights reserved.
//

import Foundation

/// A helper accessible by Rubicon to request user's input.
@objc class PyInputHelper: NSObject {
    
    /// The user's input. Set its value while Python script is waiting for input to pass the input.
    @objc static var userInput: NSMutableDictionary = NSMutableDictionary(dictionary: [String:String]())
    
    /// Returns user input for script at given path.
    ///
    /// - Parameters:
    ///     - path: The path of the script that is asking for input or an empty string.
    ///
    /// - Returns: The input entered by the user.
    @objc static func getUserInput(_ path: String) -> String? {
        return userInput.object(forKey: path) as? String
    }
    
    /// Requests for input.
    ///
    /// - Parameters:
    ///     - prompt: The prompt sent by Python function.
    ///     - script: The script that asked for input. Set to `nil` to request input on every console.
    @objc static func showAlert(prompt: String?, script: String?) {
        let prompt_ = prompt
        DispatchQueue.main.sync {
            #if !WIDGET && !MAIN
            ConsoleViewController.visibles.first?.input(prompt: prompt_ ?? "")
            #elseif !WIDGET
            for console in ConsoleViewController.visibles {
                
                if script != nil {
                    guard console.editorSplitViewController?.editor.document?.fileURL.path == script else {
                        continue
                    }
                }
                
                console.input(prompt: prompt_ ?? "")
            }
            #endif
        }
    }
    
    /// Requests for a password.
    ///
    /// - Parameters:
    ///     - prompt: The prompt sent by Python function.
    ///     - script: The script that asked for input. Set to `nil` to request input on every console.
    @objc static func getPass(prompt: String?, script: String?) {
        let prompt_ = prompt
        DispatchQueue.main.sync {
            #if !WIDGET && !MAIN
            ConsoleViewController.visibles.first?.getpass(prompt: prompt_ ?? "")
            #elseif !WIDGET
            for console in ConsoleViewController.visibles {
                
                if script != nil {
                    guard console.editorSplitViewController?.editor.document?.fileURL.path == script else {
                        continue
                    }
                }
                
                console.getpass(prompt: prompt_ ?? "")
            }
            #endif
        }
    }
}
