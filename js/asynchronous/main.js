import sqlite3 from 'sqlite3';
import { setTimeout } from "timers/promises";

let db;

function run(db, sql) {
  return new Promise((resolve, reject) => {
    db.run(sql, (error) => {
      if (!error) {
        resolve();
      } else {
        reject(error);
      }
    });
  });
}


function each(db, sql) {
  return new Promise((resolve, reject) => {
    const rows = [];

    db.each(sql, (error, row) => {
      rows.push(row);
    }, (error) => {
      if (!error) {
        resolve(rows);
      } else {
        reject(error);
      }
    });
  });
}

function close(db) {
  return new Promise((resolve, reject) => {
    db.close((error) => {
      if (!error) {
        resolve();
      } else {
        reject(error);
      }
    });
  });
}

// コールバックエラーなし

db = new sqlite3.Database(':memory:')

db.run("CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)", () => {
  let completed = 0;
  const total   = 10;

  for (let i = 0; i < total; i++) {
    db.run("INSERT INTO books (title) VALUES (?)", `TITLE${i}`, () => {
      completed++;

      if (completed === total) {
        db.each("SELECT * FROM books", (err, row) => {
          console.log(`${row.id}: ${row.title}`);
        }, () => {
          db.run("DROP TABLE books", () => {
            db.close();
          });
        });
      }
    });
  }
});

await setTimeout(10);

// コールバックエラーあり

db = new sqlite3.Database(':memory:')

db.run("CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)", () => {
  let completed = 0;
  const total   = 10;

  for(let i = 0; i < total; i++) {
    db.run("INSERT INTO books (title) VALUES (?)", null, (err) => {
      if (err) { 
        console.error(`ERROR1: ${err.message}`) 
      };

      completed++;

      if (completed === total) {
        db.each("SELECT auther FROM books", () => {
          // do nothing
        }, (err) => {
          if (err) {
            console.error(`ERROR2: ${err.message}`);
          }

          db.run("DROP TABLE books", () => {
            db.close();
          });
        });
      }
    });
  }
});

await setTimeout(10);

// Promise エラーなし

db = new sqlite3.Database(':memory:')

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
  return run(db, "DROP TABLE books");
}).finally(() => {
  return close(db);
});

await setTimeout(10);

// Promise エラーあり

db = new sqlite3.Database(':memory:')

run(db, "create table books (id integer primary key, title text not null unique)").then(() => {
  const records = [];

  for (let i = 0; i < 10; i++) {
    records.push(run(db, "insert into books (title) values (null)"));
  }

  return Promise.all(records);
}).catch((error) => {
  console.error(error.message);
  return each(db, "select title, detail from books");
}).catch((error) => {
  console.error(error.message);
  return run(db, "DROP TABLE books");
}).finally(() => {
  return close(db);
});

await setTimeout(10);

// async, await エラーなし

db = new sqlite3.Database(':memory:')

async function main1() {
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
    console.error(err.message)
  } finally {
    await run(db, "DROP TABLE books");
    await close(db);
  }
}

main1();

await setTimeout(10);

// async, await エラーあり

db = new sqlite3.Database(':memory:')

async function main2() {
  try {
    await run(db, "CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE)")

    const records = [];
    for (let i = 0; i < 10; i++) {
      records.push(run(db, "INSERT INTO books (title) VALUES (null)"));
    }

    await Promise.all(records);
  } catch (err) {
    console.error(err.message)
  }
  
  try{
    await each(db, "SELECT author FROM books");
  } catch (err) {
    console.error(err.message)
  } finally {
    await run(db, "DROP TABLE books");
    await close(db);
  }
}

main2();
