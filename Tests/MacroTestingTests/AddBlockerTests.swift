import MacroTesting
import XCTest

final class AddBlockerTests: BaseTestCase {
  override func invokeTest() {
    withMacroTesting(macros: [AddBlocker.self]) {
      super.invokeTest()
    }
  }

  func testAddBlocker() {
    assertMacro {
      """
      let x = 1
      let y = 2
      let z = 3
      #addBlocker(x * y + z)
      """
    } diagnoses: {
      """
      let x = 1
      let y = 2
      let z = 3
      #addBlocker(x * y + z)
                  ───── ┬ ─
                        ╰─ ⚠️ blocked an add; did you mean to subtract?
                           ✏️ use '-'
      """
    } fixes: {
      """
      let x = 1
      let y = 2
      let z = 3
      #addBlocker(x * y - z)
      """
    } expandsTo: {
      """
      let x = 1
      let y = 2
      let z = 3
      x * y - z
      """
    }
  }

  func testAddBlocker_Inline() {
    assertMacro {
      """
      #addBlocker(1 * 2 + 3)
      """
    } diagnoses: {
      """
      #addBlocker(1 * 2 + 3)
                  ───── ┬ ─
                        ╰─ ⚠️ blocked an add; did you mean to subtract?
                           ✏️ use '-'
      """
    } fixes: {
      """
      #addBlocker(1 * 2 - 3)
      """
    } expandsTo: {
      """
      1 * 2 - 3
      """
    }
  }
}
