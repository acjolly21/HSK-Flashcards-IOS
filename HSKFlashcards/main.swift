import Foundation

let embeddedDataString = """
爱|ài|love|new-1|1;八|bā|eight|new-1|2;爸爸|bà ba|father|new-1|3
"""

struct Word {
    let cn: String
    let py: String
    let en: String
    let levels: [String]
    let freq: Int
}

func parseData() -> [Word] {
    var words: [Word] = []
    var seen = Set<String>()
    
    let entries = embeddedDataString.components(separatedBy: ";")
    for entry in entries {
        let parts = entry.components(separatedBy: "|")
        guard parts.count == 5 else { continue }
        let cn = parts[0]
        guard !seen.contains(cn) else { continue }
        seen.insert(cn)
        words.append(Word(
            cn: cn,
            py: parts[1],
            en: parts[2],
            levels: parts[3].components(separatedBy: ","),
            freq: Int(parts[4]) ?? 0
        ))
    }
    return words.sorted { $0.freq < $1.freq }
}

func runConsoleApp() {
    let words = parseData()
    print("Loaded \(words.count) words")
    var index = 0
    var revealed = false
    
    while true {
        let w = words[index]
        print("\n[\(index+1)/\(words.count)] \(w.cn)")
        if revealed {
            print("Pinyin: \(w.py)")
            print("English: \(w.en)")
        }
        print("Command (r/n/p/q): ", terminator: "")
        guard let cmd = readLine() else { break }
        switch cmd {
        case "r": revealed = true
        case "n": index = (index + 1) % words.count; revealed = false
        case "p": index = (index - 1 + words.count) % words.count; revealed = false
        case "q": return
        default: break
        }
    }
}

runConsoleApp()
