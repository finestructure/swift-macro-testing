import InlineSnapshotTesting
import SwiftDiagnostics
import SwiftOperators
import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import XCTest

// MARK: Deprecated after 0.1.0

@available(*, deprecated, message: "Delete 'matches' and re-record this assertion")
public func assertMacro(
  _ macros: [String: Macro.Type]? = nil,
  applyFixIts: Bool = false,
  record isRecording: Bool? = nil,
  of originalSource: () throws -> String,
  matches expandedOrDiagnosedSource: () -> String,
  file: StaticString = #filePath,
  function: StaticString = #function,
  line: UInt = #line,
  column: UInt = #column
) {
  XCTFail("Delete 'matches' and re-record this assertion", file: file, line: line)
}

@available(*, deprecated, message: "Delete 'matches' and re-record this assertion")
public func assertMacro(
  _ macros: [Macro.Type],
  applyFixIts: Bool = false,
  record isRecording: Bool? = nil,
  of originalSource: () throws -> String,
  matches expandedOrDiagnosedSource: () -> String,
  file: StaticString = #filePath,
  function: StaticString = #function,
  line: UInt = #line,
  column: UInt = #column
) {
  XCTFail("Delete 'matches' and re-record this assertion", file: file, line: line)
}
