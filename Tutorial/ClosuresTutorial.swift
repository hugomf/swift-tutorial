
// Closures are self-contained blocks of functionality 
// that can be passed around and used in your code. 
// Closures in Swift are similar to blocks in C and Objective-C 
// and to lambdas in other programming languages
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

// Closure Expressions
// Nested functions, as introduced in Nested Functions, are a convenient 
// means of naming and defining self-contained blocks of code as part of a larger function
// Closure Expression Syntax
// Closure expression syntax has the following general form:
// { (parameters) -> return type in
//    statements
//  }
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
// Because the body of the closure is so short, it can even be written on a single line:
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
// Inferring Type From Context
// Swift can infer the types of its parameters and the type of the value it returns
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
// Implicit Returns from Single-Expression Closures (like implicit returs in functions)
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

// Shorthand Argument Names
// Swift automatically provides shorthand argument names to inline closures, 
// which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on
reversedNames = names.sorted(by: { $0 > $1 } )

// Operator Methods
// There’s actually an even shorter way to write the closure expression above. Swift’s String type defines 
// its string-specific implementation of the greater-than operator (>) as a method that has 
// two parameters of type String, and returns a value of type Bool. 
reversedNames = names.sorted(by: >)


// Trailing Closures
// If you need to pass a closure expression to a function as the function’s final argument and 
// the closure expression is long, it can be useful to write it as a trailing closure instead
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}
// Here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})
// Here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
// The string-sorting closure from the Closure 
// Expression Syntax section above can be written outside of the 
// sorted(by:) method’s parentheses as a trailing closure:
reversedNames = names.sorted() { $0 > $1 }
// If a closure expression is provided as the function or method’s only argument and you provide 
// that expression as a trailing closure,  you do not need to write a pair of parentheses () 
// after the function or method’s name when you call the function
reversedNames = names.sorted { $0 > $1 }
//Trailing closures are most useful when the closure is sufficiently long 
// that it is not possible to write it inline on a single line 
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]

//Capturing Values
//A closure can capture constants and variables from the surrounding context in which it is defined.
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
// The return type of makeIncrementer is () -> Int. This means that it returns a function, 
// rather than a simple value
let incrementByTen = makeIncrementer(forIncrement: 10)
print(incrementByTen())
// returns a value of 10
print(incrementByTen())
// returns a value of 20
print(incrementByTen())
// returns a value of 30

// If you create a second incrementer, it will have its own stored reference to a new, 
// separate runningTotal variable
let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven())
// returns a value of 7

// Closures Are Reference Types
let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen())
// returns a value of 40
print(incrementByTen())
// returns a value of 50
// (both are constants pointing to the same closure reference)

// Escaping closures
// A closure is said to escape a function when the closure is passed as an argument to the function, 
// but is called after the function returns.
// As an example, many functions that start an asynchronous operation take closure argument 
// as a completion handler. The function returns after it starts the operation, 
// but the closure isn’t called until the operation is completed
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"
completionHandlers.first?()
print(instance.x)
// Prints "100"


//Autoclosures
// An autoclosure is a closure that is automatically created to wrap an expression 
// that’s being passed as an argument to a function. It doesn’t take any arguments, 
//and when it’s called, it returns the value of the expression that’s wrapped inside of it
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"
print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

//You get the same behavior of delayed evaluation when you pass a closure as an argument to a function.
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

//You can call the function as if it took a String argument instead of a closure. 
//The argument is automatically converted to a closure, because the customerProvider parameter’s type 
//is marked with the @autoclosure attribute.
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"

//If you want an autoclosure that is allowed to escape, use both the @autoclosure and @escaping attributes
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"