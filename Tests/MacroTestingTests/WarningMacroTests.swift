import MacroTesting
import XCTest

final class WarningMacroTests: BaseTestCase {
  override func invokeTest() {
    withMacroTesting(macros: ["myWarning": WarningMacro.self]) {
      super.invokeTest()
    }
  }

  func testWarning() {
    assertMacro {
      #"""
      #myWarning("remember to pass a string literal here")
      """#
    } diagnoses: {
      """
      #myWarning("remember to pass a string literal here")
      ┬───────────────────────────────────────────────────
      ╰─ ⚠️ remember to pass a string literal here
      """
    } expandsTo: {
      """
      ()
      """
    }
  }

  func testNonLiteral() {
    assertMacro {
      """
      let text = "oops"
      #myWarning(text)
      """
    } diagnoses: {
      """
      let text = "oops"
      #myWarning(text)
      ┬───────────────
      ╰─ 🛑 #myWarning macro requires a string literal
      """
    }
  }
}
