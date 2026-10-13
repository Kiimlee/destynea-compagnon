import Testing
@testable import DestyneaCore

@Test func rollUnderScoreIsSuccess() {
    let result = Check.resolve(roll: 80, score: 88)
    #expect(result == .success)
}

@Test func rollAboveScoreIsFailure() {
    let result = Check.resolve(roll: 92, score: 88)
    #expect(result == .failure)
}

@Test func rollEqualScoreIsSuccess() {
    let result = Check.resolve(roll: 88, score: 88)
    #expect(result == .success)
}

@Test func rollBetweenOneAndFiveIsCriticalSuccess() {
    let result = Check.resolve(roll: 3, score: 50)
    #expect(result == .criticalSuccess)
}

@Test func rollSuccessWinsEvenAboveScore() {
    let result = Check.resolve(roll: 3, score: 2)
    #expect(result == .criticalSuccess)
}

@Test func rollBetweenNinetySixAndHundredIsCriticalFailure() {
    let result = Check.resolve(roll: 97, score: 99)
    #expect(result == .criticalFailure)
}
