//
//  RMEpisodesUseCaseTest.swift
//  RickAndMortyiOSAppTests
//
//  Created by Toni Lozano Fernández on 10/4/25.
//

import XCTest
@testable import RickAndMortyiOSApp

final class RMEpisodesUseCaseTest: XCTestCase {
    
    var successUseCase: RMEpisodesUseCase?
    var failureUseCase: RMEpisodesUseCase?
    
    override func setUp() {
        super.setUp()
        successUseCase = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFullSuccessMock())
        failureUseCase = DefaultRMEpisodesUseCase(repository: RMEpisodesRepositoryFailureMock())
    }
    
    override func tearDown() {
        successUseCase = nil
        failureUseCase = nil
        super.tearDown()
    }
    
    func testRMEpisodesUseCaseTest_Success() async throws {
        let parameters = RMEpisodesUseCaseParameters()
        
        do {
            let entity = try await successUseCase?.execute(params: parameters)
                
            // Info Model Assertions
            XCTAssertNotNil(entity)
            XCTAssertNotNil(entity?.info)
            XCTAssertNotNil(entity?.info?.count)
            XCTAssertEqual(entity?.info?.count, 51)
            XCTAssertNotNil(entity?.info?.pages)
            XCTAssertEqual(entity?.info?.pages, 3)
            XCTAssertNotNil(entity?.info?.next)
            XCTAssertEqual(entity?.info?.next, "https://rickandmortyapi.com/api/episode?page=2")
            XCTAssertNil(entity?.info?.previous)
            
            // Results Model Assertions
            XCTAssertNotNil(entity?.results)
            XCTAssertEqual(entity?.results?.count, 20)
                    
        } catch {
            XCTFail("Success test must not fail when the usecase is executed")
        }
    }
    
    func testRMEpisodesUseCaseTest_Failure() async throws {
        let parameters = RMEpisodesUseCaseParameters()
        do {
            _ = try await failureUseCase?.execute(params: parameters)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
