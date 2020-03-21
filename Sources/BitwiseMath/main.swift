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
    @Option(name: [.customLong("operation", withSingleDash: false), .customShort("o")], help: "The operand") var operation: MathOption
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
    
    @Flag(name: [.customShort("v"), .customLong("verbose", withSingleDash: false)], help: "Activate verbose kode. ASll the operations are printed.") var verbose: Bool
    func addBit(left: Int, right: Int, carry: Int) -> (Int, Int) {
        var result = 0
        var newcarry = 0
        let bitleft = left & 0b1
        let bitright = right & 0b1
        result = (bitleft ^ bitright) ^ carry
        newcarry = bitleft & bitright
        return (result, newcarry)
    }
    func run() throws {
        var argl = arg1
        var argr = arg2
        var carry = 0
        var result = 0
        var oppResult = 0
        guard operation == .addtion else {
            throw "Subtraction is not supported."
        }
        
        for i in 0...63 {
            (oppResult, carry) = addBit(left: argl, right: argr, carry: carry)
            result = result | (oppResult << i)
            argl = argl >> 1
            argr = argr >> 1
            verboseLog("result bit \(i) \(binary: oppResult), carry: \(binary: carry)")
        }
        
       
        print("Result: \(binary: result), carry: \(binary: carry)")
        
        
    }
}
ManMath.main()
    



 

