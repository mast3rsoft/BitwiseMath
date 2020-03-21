import ArgumentParser
extension String: Error {
}
extension String.StringInterpolation {
    mutating func appendInterpolation(binary: Int) {
        appendLiteral(String(binary, radix: 2))
    }
}
struct ManMath: ParsableCommand {
    static var configuration = CommandConfiguration(commandName: "manmath", abstract: "Performs calcularions with out using arithmetic operations")
    @Argument(help: "The first argument. It is the left operand") var arg1: Int
    @Argument(help: "The second argument. It is the right operand") var arg2: Int
    enum MathOption: String,Decodable, ExpressibleByArgument {
        case addtion = "+"
        case subtraction = "-"
    }
    func verboseLog(_ string: String) {
        if verbose {
            print(string)
        }
    }
    @Option(name: [.customLong("operation", withSingleDash: false), .customShort("o")], help: "The operand") var operation: MathOption
    @Flag(name: [.customShort("v"), .customLong("verbose", withSingleDash: false)], help: "Activate verbose kode. ASll the operations are printed.") var verbose: Bool
    func run() throws {
        let argl = arg1
        let argr = arg2
        var carry = 0
        var newcarry = 0
        var result = 0
        guard operation == .addtion else {
            throw "Subtraction is not supported."
        }
        let bitleft = argl & 0b1
        let bitright = argr & 0b1
        
        result = bitleft ^ bitright
        newcarry = bitleft & bitright
        result = result ^ carry
        carry = newcarry
        print("Result: \(binary: result), carry: \(binary: carry)")
        
        
    }
}
ManMath.main()
    



 

