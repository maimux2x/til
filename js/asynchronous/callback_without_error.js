import sqlite3 from 'sqlite3';

const db = new sqlite3.Database(':memory:')

db.run("CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)", () => {
  let completed = 0;
  const total = 10;

  for (let i = 0; i < total; i++) {
    db.run("INSERT INTO books (title) VALUES (?)", `TITLE${i}`, () => {
      completed++;

      if (completed === total) {
        db.each("SELECT * FROM books", (err, row) => {
          console.log(`${row.id}: ${row.title}`);
        });
      }
    });
  }
});


