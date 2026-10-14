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

@Test func criticalSuccessWinsEvenAboveScore() throws {
    let roll = try #require(D100(3))
    let result = Check.resolve(roll: roll, score: 2)
    #expect(result == .criticalSuccess)
}

@Test func rollBetweenNinetySixAndHundredIsCriticalFailure() throws {
    let roll = try #require(D100(97))
    let result = Check.resolve(roll: roll, score: 99)
    #expect(result == .criticalFailure)
}

@Test func rollUsesTheDiceResultAndIsCriticalFailure() throws {
    let dice = LoadedDice(value: try #require(D100(97)))
    let result = Check.roll(score: 99, using: dice)
    #expect(result == .criticalFailure)
}

@Test func rollUsesTheDiceResultAndIsCriticalSuccess() throws {
    let dice = LoadedDice(value: try #require(D100(3)))
    let result = Check.roll(score: 2, using: dice)
    #expect(result == .criticalSuccess)
}
