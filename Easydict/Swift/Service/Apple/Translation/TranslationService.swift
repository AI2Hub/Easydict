//
//  TranslationService.swift
//  Easydict
//
//  Created by tisfeng on 2024/10/10.
//  Copyright © 2024 izual. All rights reserved.
//

import Foundation
import SwiftUI
import Translation

@objcMembers
@available(macOS 15.0, *)
public class TranslationService: NSObject {
    // MARK: Lifecycle

    @MainActor
    public init(configuration: TranslationSession.Configuration? = nil) {
        self.configuration = configuration
        self.hostingController = TranslationService.createHostingController(manager: manager)
        super.init()
        setupView()
    }

    /// Used for objc init.
    @MainActor
    public override init() {
        self.hostingController = TranslationService.createHostingController(manager: manager)
        super.init()
        setupView()
    }

    // MARK: Public

    /// Translate text with specified source and target languages.
    /// If no languages are provided, it uses the current configuration.
    public func translate(
        text: String,
        sourceLanguage: Locale.Language? = nil,
        targetLanguage: Locale.Language? = nil
    ) async throws
        -> TranslationSession.Response {
        let source = sourceLanguage ?? configuration?.source
        let target = targetLanguage ?? configuration?.target

        return try await manager.translate(
            text: text,
            sourceLanguage: source,
            targetLanguage: target
        )
    }

    /// Translate text from source language to target language, used for objc.
    public func translate(
        text: String,
        sourceLanguage: Language,
        targetLanguage: Language
    ) async throws
        -> String {
        let response = try await translate(
            text: text,
            sourceLanguage: .init(identifier: sourceLanguage.code),
            targetLanguage: .init(identifier: targetLanguage.code)
        )
        return response.targetText
    }

    /// Translate text with language codes, providing a more flexible api.
    public func translate(
        text: String,
        sourceLanguageCode: String,
        targetLanguageCode: String
    ) async throws
        -> String {
        let response = try await translate(
            text: text,
            sourceLanguage: .init(identifier: sourceLanguageCode),
            targetLanguage: .init(identifier: targetLanguageCode)
        )
        return response.targetText
    }

    // MARK: Internal

    var configuration: TranslationSession.Configuration?

    // MARK: Private

    private let manager = TranslationManager()
    private var hostingController: NSHostingController<TranslationView>

    @MainActor
    private static func createHostingController(manager: TranslationManager) -> NSHostingController<
        TranslationView
    > {
        NSHostingController(rootView: TranslationView(manager: manager))
    }

    @MainActor
    private func setupView() {
        if let window = NSApplication.shared.windows.first {
            let translationView = hostingController.view
            window.contentView?.addSubview(translationView)
            translationView.isHidden = true
        }
    }
}