import Foundation

extension String {
    
    func extractId() -> String {
        guard let idRange = self.range(of: "\\(.*?\\)", options: .regularExpression) else {
            return ""
        }
        return String(self[idRange]).trimmingCharacters(in: ["(", ")"])
    }
    
    func extractAddress() -> String {
        guard let rangeEnd = self.range(of: " Líneas: ") else {
            return ""
        }
        let addressPart = self[..<rangeEnd.lowerBound]
        if let rangeStart = addressPart.range(of: "\\) ", options: .regularExpression)?.upperBound {
            return String(addressPart[rangeStart...])
        }
        return ""
    }
    
    func toTitleCase() -> String {
        let words = self.lowercased().components(separatedBy: " ")
        var titleCaseWords = [String]()
        for word in words {
            if !word.isEmpty {
                let firstLetter = word.prefix(1).uppercased()
                let restOfWord = word.dropFirst()
                let titleCaseWord = firstLetter + restOfWord
                titleCaseWords.append(titleCaseWord)
            }
        }
        return titleCaseWords.joined(separator: " ")
    }
    
    func extractLines() -> [String] {
        let pattern = "Líneas: ([A-Za-z0-9, ]+)"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        guard let match = results.first else { return [] }
        
        let lineNumbersRange = Range(match.range(at: 1), in: self)!
        let lineNumbers = self[lineNumbersRange]
        
        return lineNumbers.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespaces) }
    }
}
