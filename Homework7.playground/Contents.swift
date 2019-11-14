import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.

// MARK: - STEP ONE

// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.

// MARK: - STEP TWO

// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.

// MARK: - STEP THREE

// Now we need to publish this data to the server.

// Create a URL to connect to the server. Its address is:
//      https://uofd-tldrserver-develop.vapor.cloud/books

// Create a URL request to publish the information, based upon the URL you
// just created.

// Add the body to the URL request you just created, by using JSONEncoder.

// Add a "Content-Type" : "application/json" header to your request, so that
// the server will properly understand the body of your request.

// Set the method of the request to "POST", because we're providing information
// rather than retrieving it.

// Create a data task for publishing this element, and kick it off with a resume().

// MARK: - HELPFUL HINTS
// You might want to create a method for publishing the data, so that you
// can effectively loop over an array of books.
//
// If you visit the URL for the service in a 'GET' request, it will return a
// list of books to you. We'll be using this list of books for Project Three.

struct Book: Codable{
    let id: Int?
    let title: String
    let author: String
    let publicationYear: String
    let imageURLString: String
}


let lesMiserables = Book(id: nil, title: "Les Miserables", author: "Victor Hugo", publicationYear: "1862", imageURLString: "https://images1.penguinrandomhouse.com/cover/9780451419439")


let theBookThief = Book(id: nil, title: "The Book Thief", author: "Marcus Zusak", publicationYear: "2005", imageURLString: "https://upload.wikimedia.org/wikipedia/en/8/8f/The_Book_Thief_by_Markus_Zusak_book_cover.jpg")


let braveNewWorld = Book(id: nil, title: "Brave New World", author: "Aldous Huxley", publicationYear: "1932", imageURLString: "https://upload.wikimedia.org/wikipedia/en/6/62/BraveNewWorld_FirstEdition.jpg")

let bloodMeridian = Book(id: nil, title: "Blood Meridian or The Evening Redness in the West", author: "Cormac McCarthy", publicationYear: "1985", imageURLString: "https://upload.wikimedia.org/wikipedia/en/d/de/CormacMcCarthy_BloodMeridian.jpg")

let endersGame = Book(id: nil, title: "Ender's Game", author: "Orson Scott Card", publicationYear: "1985" , imageURLString: "https://en.wikipedia.org/wiki/Ender%27s_Game#/media/File:Ender's_game_cover_ISBN_0312932081.jpg")

let books = [lesMiserables, theBookThief, braveNewWorld, bloodMeridian, endersGame]


func publishBook(book:Book){
    let urlString = "https://uofd-tldrserver-develop.vapor.cloud/books"
    let url = URL(string: urlString)!

    var request = URLRequest(url: url)
    request.httpBody = try? JSONEncoder().encode(book)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    
    let task = URLSession(configuration: .ephemeral).dataTask(with: request)
    task.resume()
    
}

for book in books{
    publishBook(book: book)
}
