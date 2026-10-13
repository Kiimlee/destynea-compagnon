import Testing
@testable import DestyneaCore

@Test func rollUnderScoreIsSuccess() throws {
    let roll = try #require(D100(80))
    let result = Check.resolve(roll: roll, score: 88)
    #expect(result == .success)
}

@Test func rollAboveScoreIsFailure() throws {
    let roll = try #require(D100(92))
    let result = Check.resolve(roll: roll, score: 88)
    #expect(result == .failure)
}

@Test func rollEqualScoreIsSuccess() throws {
    let roll = try #require(D100(88))
    let result = Check.resolve(roll: roll, score: 88)
    #expect(result == .success)
}

@Test func rollBetweenOneAndFiveIsCriticalSuccess() throws {
    let roll = try #require(D100(3))
    let result = Check.resolve(roll: roll, score: 50)
    #expect(result == .criticalSuccess)
}

@Test func rollSuccessWinsEvenAboveScore() throws {
    let roll = try #require(D100(3))
    let result = Check.resolve(roll: roll, score: 2)
    #expect(result == .criticalSuccess)
}

@Test func rollBetweenNinetySixAndHundredIsCriticalFailure() throws {
    let roll = try #require(D100(97))
    let result = Check.resolve(roll: roll, score: 99)
    #expect(result == .criticalFailure)
}
