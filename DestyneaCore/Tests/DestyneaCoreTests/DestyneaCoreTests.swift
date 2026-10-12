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
