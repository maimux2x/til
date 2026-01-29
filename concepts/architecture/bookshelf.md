```mermaid
classDiagram
    class Book {
        title
        author
        publisher
        published_at
    }

    class ReadingLog {
        status
        comment
    }

    class User {
        name
        email
    }

    User "1" --> "0..*" ReadingLog
    ReadingLog "0..1" --> "0..*" Book
```
