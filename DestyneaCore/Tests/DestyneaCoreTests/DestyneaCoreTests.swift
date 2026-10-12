import Testing
@testable import DestyneaCore

@Test func rollUnderScoreIsSuccess() {
    let result = Check.resolve(roll: 80, score: 88)
    #expect(result == .success)
}
