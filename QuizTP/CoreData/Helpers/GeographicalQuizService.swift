import Foundation
import CoreData

public final class GeographicalQuizService {
  let managedObjectContext: NSManagedObjectContext
  let coreDataStack: CoreDataStack

  public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
    self.managedObjectContext = managedObjectContext
    self.coreDataStack = coreDataStack
  }
}

extension GeographicalQuizService {
  @discardableResult
    public func add(questionCategory: String, answerA: String, answerB: String, answerC: String, answerD: String, rightAnswer: String, countryCode: String) -> GeographicalQuestions {
    let geographicalQuestion = GeographicalQuestions(context: managedObjectContext)
        
    geographicalQuestion.questionCategory = questionCategory
    geographicalQuestion.rightAnswer = rightAnswer
    geographicalQuestion.countryCode = countryCode

    geographicalQuestion.answerA = answerA
    geographicalQuestion.answerB = answerB
    geographicalQuestion.answerC = answerC
    geographicalQuestion.answerD = answerD

    coreDataStack.saveContext(managedObjectContext)
    return geographicalQuestion
  }

  public func getQuestions() -> [GeographicalQuestions]? {
    let reportFetch: NSFetchRequest<GeographicalQuestions> = GeographicalQuestions.fetchRequest()
    do {
      let results = try managedObjectContext.fetch(reportFetch)
      return results
    } catch let error as NSError {
      print("Fetch error: \(error) description: \(error.userInfo)")
    }
    return nil
  }

//  @discardableResult
//  public func update(_ report: PandemicReport) -> PandemicReport {
//    coreDataStack.saveContext(managedObjectContext)
//    return report
//  }
//
//  public func delete(_ report: PandemicReport) {
//    managedObjectContext.delete(report)
//    coreDataStack.saveContext(managedObjectContext)
//  }
}

