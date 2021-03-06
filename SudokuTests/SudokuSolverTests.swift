//
//  SudokuSolverTests.swift
//  SudokuSolverTests
//
//  Created by Ben Sweett on 2016-03-16.
//  Copyright © 2016 Ben Sweett. All rights reserved.
//

import XCTest
@testable import Sudoku

class SudokuSolverTests: XCTestCase {
    
    private var algorithm: SudokuSolver?
    
    override func setUp() {
        super.setUp()
        
        self.algorithm = SudokuSolver()
    }
    
    override func tearDown() {
        
        self.algorithm = nil
        
        super.tearDown()
    }
    
    /**
     Tests that a puzzle can be solved using the algorithms
     */
    func testSolve() {
        
        let demo = SudokuType.Default.constructPuzzle()
        let result = self.algorithm?.solve(demo)
        XCTAssertNotNil(result, "The algorithm must be able to solve the demo puzzle.")
    }
    
    /**
     Tests setting a number in the working copy of a puzzle
     */
    func testGetWorkingCopy() {
        
        let demo = SudokuType.Default.constructPuzzle()
    
        //  Build a cell in the top left corener and update it in the demo puzzle
        let cell = SudokuCell(row: 0, col: 8)
        let updatedPuzzle = self.algorithm?.getWorkingCopyOfPuzzle(demo, forCell: cell, withNumber: 5)
        
        //  Check that that cell was in fact updated
        XCTAssertEqual(updatedPuzzle?[0][8], 5, "The cell loacted at row 0 column 8 should now be 5.")
    }
    
    /**
     Tests getting an empty cell from an unfinished puzzle
     */
    func testGetNextEmptyCellInPuzzle() {
        
        let demo = SudokuType.Default.constructPuzzle()
        
        let cell = self.algorithm?.getNextEmptyCellInPuzzle(demo)
        
        XCTAssertNotNil(cell, "A cell should be returned from the demo puzzle that is empty.")
        XCTAssertEqual(cell?.row, 0, "The first empty cell should be in row 0.")
        
        if let solution = self.algorithm?.solve(demo) {
            let noCell = self.algorithm?.getNextEmptyCellInPuzzle(solution)
            XCTAssertNil(noCell, "Once solved the puzzle should not have anymore empty cells.")
        }
    }
    
    /**
     Tests if a number is a valid entry on the puzzle
     */
    func testIsNumberValid() {
        
        let easy = SudokuType.Easy.constructPuzzle()
        
        let testCell = SudokuCell(row: 0, col: 0)
        let result = self.algorithm?.isNumberValid(9, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(result, "The returned value from isNumberValid should not be nil.")
        XCTAssertTrue(result == true, "The input of 9 for cell at row 0 column 0 should return true for isNumberValid.")
        
        let failedResult = self.algorithm?.isNumberValid(5, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(failedResult, "The returned value from isNumberValid should not be nil.")
        XCTAssertFalse(failedResult == true, "The input of 5 for cell at row 0 column 0 should return false for isNumberValid.")
    }
    
    /**
     Tests if a number is a valid entry for a box in the puzzle
     */
    func testIsNumberValidForBox() {
        
        let easy = SudokuType.Easy.constructPuzzle()
        
        let testCell = SudokuCell(row: 0, col: 0)
        let result = self.algorithm?.isNumberValidForBox(8, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(result, "The returned value from isNumberValidForBox should not be nil.")
        XCTAssertTrue(result == true, "The input of 8 for cell at row 0 column 0 should return true for isNumberValidForBox.")
        
        let failedResult = self.algorithm?.isNumberValidForBox(1, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(failedResult, "The returned value from isNumberValidForBox should not be nil.")
        XCTAssertFalse(failedResult == true, "The input of 1 for cell at row 0 column 0 should return false for isNumberValidForBox.")
    }
    
    /**
     Tests if a number is a valid entry for a row in the puzzle
     */
    func testIsNumberValidForRow() {
        
        let easy = SudokuType.Easy.constructPuzzle()
        
        let testCell = SudokuCell(row: 0, col: 0)
        let result = self.algorithm?.isNumberValidForRow(5, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(result, "The returned value from isNumberValidForRow should not be nil.")
        XCTAssertTrue(result == true, "The input of 5 for cell at row 0 column 0 should return true for isNumberValidForRow.")
        
        let failedResult = self.algorithm?.isNumberValidForRow(1, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(failedResult, "The returned value from isNumberValidForRow should not be nil.")
        XCTAssertFalse(failedResult == true, "The input of 1 for cell at row 0 column 0 should return false for isNumberValidForRow.")
    }
    
    /**
     Tests if a number is a valid entry for a column in the puzzle
     */
    func testIsNumberValidForColumn() {
        
        let easy = SudokuType.Easy.constructPuzzle()
        
        let testCell = SudokuCell(row: 0, col: 0)
        let result = self.algorithm?.isNumberValidForColumn(2, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(result, "The returned value from isNumberValidForColumn should not be nil.")
        XCTAssertTrue(result == true, "The input of 2 for cell at row 0 column 0 should return true for isNumberValidForColumn.")
        
        let failedResult = self.algorithm?.isNumberValidForColumn(1, forCell: testCell, inPuzzle: easy)
        
        XCTAssertNotNil(failedResult, "The returned value from isNumberValidForColumn should not be nil.")
        XCTAssertFalse(failedResult == true, "The input of 1 for cell at row 0 column 0 should return false for isNumberValidForColumn.")
    }

    /**
     Test the performance of the solve function with a hard puzzle
     */
    func testHardSolvePerformance() {

        let hard = SudokuType.Hard.constructPuzzle()
        
        if let algo = self.algorithm {
            self.measureBlock {
                algo.solve(hard)
            }
        } else {
            XCTFail("This test requires an algorithm to be initalized.")
        }
    }
    
    /**
     Tests the performance of the solve function with a easy puzzle
     */
    func testEasySolvePerformance() {
        
        let easy = SudokuType.Easy.constructPuzzle()
        
        if let algo = self.algorithm {
            self.measureBlock {
                algo.solve(easy)
            }
        } else {
            XCTFail("This test requires an algorithm to be initalized.")
        }
    }
    
}
