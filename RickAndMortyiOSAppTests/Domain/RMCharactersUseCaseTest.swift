//
//  RMCharactersUseCaseTest.swift
//  RickAndMortyiOSAppTests
//
//  Created by Toni Lozano Fernández on 10/4/25.
//

import XCTest
@testable import RickAndMortyiOSApp

final class RMCharactersUseCaseTest: XCTestCase {
    
    var successUseCase: RMCharactersUseCase?
    var failureUseCase: RMCharactersUseCase?
    
    override func setUp() {
        super.setUp()
        successUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositorySuccessMock())
        failureUseCase = DefaultRMCharactersUseCase(repository: RMCharactersRepositoryFailureMock())
    }
    
    override func tearDown() {
        successUseCase = nil
        failureUseCase = nil
        super.tearDown()
    }

    func testRMCharactersUseCaseTest_Success() async throws {
        let parameters = RMCharactersUseCaseParameters()
        do {
            let entity = try await successUseCase?.execute(params: parameters)
                
            // Info Model Assertions
            XCTAssertNotNil(entity)
            XCTAssertNotNil(entity?.info)
            XCTAssertNotNil(entity?.info?.count)
            XCTAssertEqual(entity?.info?.count, 826)
            XCTAssertNotNil(entity?.info?.pages)
            XCTAssertEqual(entity?.info?.pages, 42)
            XCTAssertNotNil(entity?.info?.next)
            XCTAssertEqual(entity?.info?.next, "https://rickandmortyapi.com/api/character?page=2")
            XCTAssertNil(entity?.info?.previous)
            
            // Results Model Assertions+
            XCTAssertNotNil(entity?.results)
            XCTAssertEqual(entity?.results?.count, 20)
            
        } catch {
            XCTFail("Success test must not fail when the usecase is executed")
        }
    }
    
    func testRMCharactersUseCaseTest_Success_noPagination() async throws {
        let parameters = RMCharactersUseCaseParameters()
        do {
            let entity = try await successUseCase?.execute(params: parameters)
                
            // Info Model Assertions
            XCTAssertNotNil(entity)
            XCTAssertNotNil(entity?.info)
            XCTAssertNotNil(entity?.info?.count)
            XCTAssertEqual(entity?.info?.count, 826)
            XCTAssertNotNil(entity?.info?.pages)
            XCTAssertEqual(entity?.info?.pages, 42)
            XCTAssertNotNil(entity?.info?.next)
            XCTAssertEqual(entity?.info?.next, "https://rickandmortyapi.com/api/character?page=2")
            XCTAssertNil(entity?.info?.previous)
            
            // Results Model Assertions+
            XCTAssertNotNil(entity?.results)
            XCTAssertEqual(entity?.results?.count, 20)
            
        } catch {
            XCTFail("Success test must not fail when the usecase is executed")
        }
    }
    
    func testRMCharactersUseCaseTest_Failure() async throws {
        let parameters = RMCharactersUseCaseParameters()
        
        do {
        let _ = try await failureUseCase?.execute(params: parameters)
            XCTFail("Failure test must not succeed when the usecase is executed")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

