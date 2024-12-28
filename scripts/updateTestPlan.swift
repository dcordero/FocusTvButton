import Foundation

// Function to find the absolute path where the script is running (directory containing Package.swift)
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

// Function to escape forward slashes in paths
func escapePath(_ path: String) -> String {
    return path.replacingOccurrences(of: "/", with: "\\/")
}

// Function to update the .xctestplan file by replacing the SOURCE_ROOT value
func updateTestPlanFile(testPlanPath: String, sourceRoot: String) {
    do {
        var testPlan = try String(contentsOfFile: testPlanPath, encoding: .utf8)

        // Escape the sourceRoot path to handle special characters like "/"
        let escapedSourceRoot = escapePath(sourceRoot)

        // Look for existing "SOURCE_ROOT" entry and replace it
        let sourceRootPattern = "\"key\" : \"SOURCE_ROOT\","
        let newSourceRootLine = "\"value\" : \"\(escapedSourceRoot)\"\n"

        if let range = testPlan.range(of: sourceRootPattern) {
            // Replace the value line after "key" : "SOURCE_ROOT"
            if let startRange = testPlan.range(of: "\"value\" :", range: range.upperBound..<testPlan.endIndex) {
                if let endRange = testPlan.range(of: "\n", range: startRange.upperBound..<testPlan.endIndex) {
                    testPlan.replaceSubrange(startRange.lowerBound..<endRange.upperBound, with: newSourceRootLine)
                } else {
                    // If the newline after the value is not found, add the new line directly
                    testPlan.insert(contentsOf: newSourceRootLine, at: startRange.upperBound)
                }
            }
        } else {
            // If "SOURCE_ROOT" is not found, add the entry at the appropriate location
            let sourceRootEntry = """
            {
                "key" : "SOURCE_ROOT",
                "value" : "\(escapedSourceRoot)"
            }
            """
            // Add it before the closing bracket of the file content, ensuring proper JSON format
            testPlan += ",\n" + sourceRootEntry
        }

        // Write the updated content back to the file
        try testPlan.write(toFile: testPlanPath, atomically: true, encoding: .utf8)
        print("Updated SOURCE_ROOT path to: \(escapedSourceRoot)")

    } catch {
        fatalError("Failed to read or update the test plan: \(error)")
    }
}

// Path to the xctestplan file (updated to FocusTvButtonSPM.xctestplan)
let testPlanPath = "./FocusTvButtonSPM.xctestplan"

// Get the source root directory as an absolute path
let sourceRoot = findSourceRoot()

// Update the test plan file with the new SOURCE_ROOT value
updateTestPlanFile(testPlanPath: testPlanPath, sourceRoot: sourceRoot)
