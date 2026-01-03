import { db, run, each } from './index.js'


run(db, "CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)").then(() => {
  const records = [];

  for (let i = 0; i < 10; i++) {
    records.push(run(db, `INSERT INTO books (title, detail) VALUES ('TITLE${i}')`));
  }

  return Promise.all(records);
}).then(() => {
  return each(db, "SELECT title, detail FROM books");
}).then((rows) => {
  rows.forEach(row => console.log(row.title));
}).catch((error) => {
  console.log(error);
}).finally(() => {
  run(db, "DROP TABLE books").finally(() => {
    db.close();
  });
});
