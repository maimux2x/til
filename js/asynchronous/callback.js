import sqlite3 from "sqlite3"

const db = new sqlite3.Database(":memory:");

db.run("CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)", (err) => {
  let completed = 0;
  const total = 10;

  for(let i = 0; i < total; i++) {
    db.run("INSERT INTO books (title, details) VALUES (?, ?)", `TITLE${i}`, (err) => {
      if (err) { 
        console.log(`ERROR1: ${err}`) 
      };
      completed++;

      if(completed === total) {
        db.each("SELECT title, detail FROM books", (err, row) => {
          if (err) {
            console.log(`ERROR2: ${err}`);
          }
        }, () => {
          db.run("DROP TABLE books", () => {
            db.close();
          });
        });
      }
    });
  }
});
