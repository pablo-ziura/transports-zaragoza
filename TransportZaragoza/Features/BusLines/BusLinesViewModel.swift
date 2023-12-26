import Foundation

class BusLinesViewModel: ObservableObject {
    
    @Published var busLines: [String: [BusStop]] = [:]
    @Published var isLoading = false
    @Published var error: Error?
    
    private let busStopsRepository: BusStopsRepository
    
    init(busStopsRepository: BusStopsRepository) {
        self.busStopsRepository = busStopsRepository
    }
    
    @MainActor
    func getBusLines() async {
        isLoading = true
        do {
            let busStopsList = try await busStopsRepository.getBusStops()
            var linesDictionary = [String: [BusStop]]()
            
            for busStop in busStopsList {
                let lines = extractLines(from: busStop.title)
                for line in lines {
                    linesDictionary[line, default: []].append(busStop)
                }
            }
            busLines = linesDictionary
        } catch {
            self.error = error
            print("Error al obtener las líneas de autobús:", error)
        }
        isLoading = false
    }

    private func extractLines(from title: String) -> [String] {
        let pattern = "Líneas: ([A-Za-z0-9, ]+)"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let results = regex.matches(in: title, range: NSRange(title.startIndex..., in: title))
        guard let match = results.first else { return [] }
        
        let lineNumbersRange = Range(match.range(at: 1), in: title)!
        let lineNumbers = title[lineNumbersRange]
        return lineNumbers.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespaces) }
    }
    
}
