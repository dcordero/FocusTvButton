import Foundation

// Function to determine the absolute source root path
func findSourceRoot() -> String {
    let fileManager = FileManager.default
    let currentDirectory = fileManager.currentDirectoryPath

    // Check if Package.swift exists in the current directory
    let packagePath = currentDirectory + "/Package.swift"
    if fileManager.fileExists(atPath: packagePath) {
        return currentDirectory
    } else {
        fatalError("Package.swift not found in the current directory: \(currentDirectory)")
    }
}

// Function to escape slashes for JSON formatting
func escapePath(_ path: String) -> String {
    return path.replacingOccurrences(of: "/", with: "\\/")
}

// Function to update FB_REFERENCE_IMAGE_DIR and IMAGE_DIFF_DIR
func updateDependentVariables(testPlanPath: String, sourceRoot: String) {
    do {
        var testPlan = try String(contentsOfFile: testPlanPath, encoding: .utf8)

        let escapedSourceRoot = escapePath(sourceRoot)

        // Update FB_REFERENCE_IMAGE_DIR
        if let range = testPlan.range(of: "\"FB_REFERENCE_IMAGE_DIR\"") {
            if let valueRange = testPlan.range(of: "\"value\" : \"", range: range.upperBound..<testPlan.endIndex) {
                if let endRange = testPlan.range(of: "\"", range: valueRange.upperBound..<testPlan.endIndex) {
                    testPlan.replaceSubrange(valueRange.upperBound..<endRange.lowerBound,
                                             with: "\(escapedSourceRoot)\\/FocusTvButton\\/FocusTvButtonTests\\/ReferenceImages")
                }
            }
        }

        // Update IMAGE_DIFF_DIR
        if let range = testPlan.range(of: "\"IMAGE_DIFF_DIR\"") {
            if let valueRange = testPlan.range(of: "\"value\" : \"", range: range.upperBound..<testPlan.endIndex) {
                if let endRange = testPlan.range(of: "\"", range: valueRange.upperBound..<testPlan.endIndex) {
                    testPlan.replaceSubrange(valueRange.upperBound..<endRange.lowerBound,
                                             with: "\(escapedSourceRoot)\\/FocusTvButton\\/FocusTvButtonTests\\/FailureDiffs")
                }
            }
        }

        // Write the updated test plan back to the file
        try testPlan.write(toFile: testPlanPath, atomically: true, encoding: .utf8)
        print("Updated FB_REFERENCE_IMAGE_DIR and IMAGE_DIFF_DIR paths successfully.")

    } catch {
        fatalError("Failed to read or update the test plan: \(error)")
    }
}

// Path to the test plan file
let testPlanPath = "./FocusTvButtonSPM.xctestplan"

// Get the source root directory as an absolute path
let sourceRoot = findSourceRoot()

// Update the dependent variables in the test plan
updateDependentVariables(testPlanPath: testPlanPath, sourceRoot: sourceRoot)
