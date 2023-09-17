import MacroTesting
import XCTest

final class URLMacroTests: BaseTestCase {
  override func invokeTest() {
    withMacroTesting(macros: ["URL": URLMacro.self]) {
      super.invokeTest()
    }
  }

  func testURL() {
    assertMacro {
      #"""
      print(#URL("https://swift.org/"))
      """#
    } expandsTo: {
      """
      print(URL(string: "https://swift.org/")!)
      """
    }
  }

  func testNonStaticURL() {
    assertMacro {
      #"""
      let domain = "domain.com"
      print(#URL("https://\(domain)/api/path"))
      """#
    } diagnoses: {
      #"""
      let domain = "domain.com"
      print(#URL("https://\(domain)/api/path"))
            ┬─────────────────────────────────
            ╰─ 🛑 #URL requires a static string literal
      """#
    }
  }

  func testMalformedURL() {
    assertMacro {
      #"""
      print(#URL("https://not a url.com"))
      """#
    } diagnoses: {
      """
      print(#URL("https://not a url.com"))
            ┬────────────────────────────
            ╰─ 🛑 malformed url: "https://not a url.com"
      """
    }
  }
}
