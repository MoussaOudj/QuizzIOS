import XCTest
import QuizTP
import CoreData

class TestCoreData: XCTestCase {
    var coreDataStack: CoreDataStack!
    var geoQuizService: GeographicalQuizService!

    override func setUp() {
      super.setUp()
      coreDataStack = TestCoreDataStack()
        geoQuizService = GeographicalQuizService(
        managedObjectContext: coreDataStack.mainContext,
        coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
      super.tearDown()
        self.geoQuizService = nil
        self.coreDataStack = nil
    }
    
    func testQuestionCreation() {
        let geoQuestion = geoQuizService.add(
            questionCategory: "AFRIQUE",
            answerA: "Mauritanie",
            answerB: "Algérie",
            answerC: "Mali",
            answerD: "Libye",
            rightAnswer: "Algérie",
            countryCode: "DZA")

          XCTAssertNotNil(geoQuestion, "question should not be nil")
          XCTAssertTrue(geoQuestion.answerA == "Mauritanie")
          XCTAssertTrue(geoQuestion.answerB == "Algérie")
          XCTAssertTrue(geoQuestion.answerC == "Mali")
          XCTAssertTrue(geoQuestion.answerD == "Libye")

          XCTAssertTrue(geoQuestion.rightAnswer == "Algérie")
          XCTAssertTrue(geoQuestion.countryCode == "DZA")
    }
    
    func testQuestionSaving() {

      let derivedContext = coreDataStack.newDerivedContext()
      geoQuizService = GeographicalQuizService(
        managedObjectContext: derivedContext,
        coreDataStack: coreDataStack)
        
      expectation(
        forNotification: .NSManagedObjectContextDidSave,
        object: coreDataStack.mainContext) { _ in
          return true
      }

      derivedContext.perform {
        let geoQuestion = self.geoQuizService.add(
            questionCategory: "AFRIQUE",
            answerA: "Mauritanie",
            answerB: "Algérie",
            answerC: "Mali",
            answerD: "Libye",
            rightAnswer: "Algérie",
            countryCode: "DZA")

        XCTAssertNotNil(geoQuestion)
      }

      waitForExpectations(timeout: 2.0) { error in
        XCTAssertNil(error, "Save did not occur")
      }
    }
    
    func testFetchOneQuesion() {
        let geoQuestion = self.geoQuizService.add(
            questionCategory: "AFRIQUE",
            answerA: "Mauritanie",
            answerB: "Algérie",
            answerC: "Mali",
            answerD: "Libye",
            rightAnswer: "Algérie",
            countryCode: "DZA")
        
      let getQuestions = geoQuizService.getQuestions()

        XCTAssertNotNil(getQuestions)
        XCTAssertTrue(getQuestions?.count == 1)
    }
    
    
    func testFetchWholeQuiz() {
        let question1 = self.geoQuizService.add(
            questionCategory: "AFRIQUE",
            answerA: "Mauritanie",
            answerB: "Algérie",
            answerC: "Mali",
            answerD: "Libye",
            rightAnswer: "Algérie",
            countryCode: "DZA")
        
        let question2 = self.geoQuizService.add(
            questionCategory: "AFRIQUE",
             answerA: "Angola",
             answerB: "Botswana",
             answerC: "Somalie",
             answerD: "Tunisie",
             rightAnswer: "Angola",
             countryCode: "AGO")

        
        let question3 = self.geoQuizService.add(
            questionCategory: "AFRIQUE",
             answerA: "Tunisie",
             answerB: "Mauritanie",
             answerC: "Madagascar",
             answerD: "Maroc",
             rightAnswer: "Maroc",
             countryCode: "MAR")

        
        let question4 = self.geoQuizService.add(
            questionCategory: "AFRIQUE",
             answerA: "Algerie",
             answerB: "Egypte",
             answerC: "Afrique du Sud",
             answerD: "Sénégal",
             rightAnswer: "Egypte",
             countryCode: "EGY")

        
        let question5 = self.geoQuizService.add(
            questionCategory: "AFRIQUE",
             answerA: "Afrique du Sud",
             answerB: "Mozambique",
             answerC: "Botswana",
             answerD: "Namibie",
             rightAnswer: "Afrique du Sud",
             countryCode: "ZAF")

        
      let getQuestions = geoQuizService.getQuestions()

        XCTAssertNotNil(getQuestions)
        XCTAssertTrue(getQuestions?.count == 5)
    }
}
