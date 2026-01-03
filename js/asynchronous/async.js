import { db, run, each } from './index.js'

async function main() {
  try {
    await run(db, "CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)")

    const records = [];
    for (let i = 0; i < 10; i++) {
      records.push(run(db, `INSERT INTO books (title) VALUES ('TITLE${i}')`));
    }

    await Promise.all(records);

    const rows = await each(db, "SELECT * FROM books");
    rows.forEach(row => console.log(`${row.id}: ${row.title}`));
  } catch (err) {
    console.error(err)
  } finally {
    await run(db, "DROP TABLE books");
    db.close();
  }
}

main();
