import sqlite3 from 'sqlite3';

const db = new sqlite3.Database(':memory:')

function run(db, sql) {
  return new Promise((resolve) => {
    db.run(sql, (error) => {
      resolve();
    });
  });
}

function each(db, sql) {
  return new Promise((resolve) => {
    const rows = [];

    db.each(sql, (error, row) => {
      rows.push(row);
    }, () => {
      resolve(rows);
    });
  });
}

run(db, "CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)").then(() => {
  const records = [];

  for (let i = 0; i < 10; i++) {
    records.push(run(db, `INSERT INTO books (title) VALUES ('TITLE${i}')`));
  }

  return Promise.all(records);
}).then(() => {
  return each(db, "SELECT * FROM books");
}).then((rows) => {
  rows.forEach(row => console.log(`${row.id}: ${row.title}`));
});
