//
//  AstronomyUITests.swift
//  AstronomyUITests
//
//  Created by Lambda_School_Loaner_219 on 1/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest

class AstronomyUITests: XCTestCase {

    override func setUp() {
        let app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
        continueAfterFailure = false

 
}
    
    private enum SolButtons: String {
        case previous = "PhotosCollectionViewController.PreviousSolButton"
        case next = "PhotosCollectionViewController.NextSolButton"
    }
    
    private enum DetailLabels: String {
        case detailLabel = "PhotoInfoLabel"
        case cameraLabel = "cameraLabel"
    }
    
    func testMoveToNextSol() {
        let app = XCUIApplication()
        app.navigationBars["Sol 15"].buttons[SolButtons.next.rawValue].tap()
        XCTAssertEqual(app.navigationBars["Sol 14"].exists, true)
        
    }
    
    func testSavingPhoto() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        let photodetailviewcontrollerSavebuttonButton = app/*@START_MENU_TOKEN@*/.buttons["PhotoDetailViewController.SaveButton"];/*[[".buttons[\"Save to Photo Library\"]",".buttons[\"PhotoDetailViewController.SaveButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/            photodetailviewcontrollerSavebuttonButton.tap()
        
        addUIInterruptionMonitor(withDescription: "Photo Dialog") { (alert) -> Bool in
            let okButton = alert.scrollViews.otherElements.buttons["OK"]
            if okButton.exists {
                XCTAssertEqual(okButton.exists, true)
                okButton.tap()
               photodetailviewcontrollerSavebuttonButton
            }
            return true
        }
        app.tap()
    }
    
    func testDetailViewPopulated() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        XCTAssertEqual(app.navigationBars["Title"].exists, true)
        XCTAssertEqual(app.staticTexts[DetailLabels.detailLabel.rawValue].label, "Taken by 5 on 8/20/12, 8:00 PM (Sol 15)")
        
        XCTAssertEqual(app.staticTexts[DetailLabels.cameraLabel.rawValue].label, "Front Hazard Avoidance Camera")
    }
}
