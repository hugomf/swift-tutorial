let worldCharacters: [Character] = ["W", "o", "r", "l", "d"]
var worldString = String(worldCharacters)
print(worldString)

// add a character to the string
let exclamationMark : Character = "!"
worldString.append(exclamationMark)
print(worldString)


// string concatenation 
let string1 = "Hello"
let string2 = " World"
let welcome = string1 + string2
print(welcome)

//String interpolation
let score = 130
let message = "Congratulations, you scored \(score)!"
print(message)

// interpolated with an operation
let message2 = "That's an average of \(score / 5) per turn."
print(message2)

//interpolated with string literals
let interpolatedString = "This is an \("interpolated") string"
print(interpolatedString)

// isEmpty
let emptyString1 = ""
if emptyString1.isEmpty {
    print("The string was empty")
}

// iterate through string
let hello = "Hello"
for character in hello {
    print(character, terminator:" ")
}
print("");
// H e l l o


// multiple lines
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
print(quotation)


var word = "cafe"
print("the number of characters in \(word) is \(word.count)")


word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in café is 4"

//strng index


// let greeting = "Guten Tag!"
// greeting[greeting.startIndex]
// // G
// greeting[greeting.index(before: greeting.endIndex)]
// // !
// greeting[greeting.index(after: greeting.startIndex)]
// // u
// let index = greeting.index(greeting.startIndex, offsetBy: 7)
// greeting[index]
// // a

