//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {
    
    func testGenresResponse() {
        var sut: GenresResponse!
          
        func setUpWithError() throws {
            super.setUp()
            let data = try getData(fromJSON: "ListGenres")
            sut = try JSONDecoder().decode(GenresResponse.self, from: data)
        }
          
        func tearDownWithError() throws {
            sut = nil
            super.tearDown()
        }
          
        func testJSONMapping() {
            XCTAssertEqual(sut.genres.count, 19)
        }
    }
    
    func testListMoviesResponse() {
        var sut: ListMovieResponse!
          
        func setUpWithError() throws {
            super.setUp()
            let data = try getData(fromJSON: "ListMovies")
            sut = try JSONDecoder().decode(ListMovieResponse.self, from: data)
        }
          
        func tearDownWithError() throws {
            sut = nil
            super.tearDown()
        }
          
        func testJSONMapping() {
            XCTAssertEqual(sut.results.count, 20)
        }
    }
    
    func testDetailMovieResponse() {
        var sut: DetailMovieResponse!
          
        func setUpWithError() throws {
            super.setUp()
            let data = try getData(fromJSON: "DetailMovie")
            sut = try JSONDecoder().decode(DetailMovieResponse.self, from: data)
        }
          
        func tearDownWithError() throws {
            sut = nil
            super.tearDown()
        }
          
        func testJSONMapping() {
            XCTAssertEqual(sut.id, 766507)
        }
    }
}

extension XCTestCase {
  enum TestError: Error {
    case fileNotFound
  }
  
  func getData(fromJSON fileName: String) throws -> Data {
    let bundle = Bundle(for: type(of: self))
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
      XCTFail("Missing File: \(fileName).json")
      throw TestError.fileNotFound
    }
    do {
      let data = try Data(contentsOf: url)
      return data
    } catch {
      throw error
    }
  }
}
