import sqlite3 from 'sqlite3';

const db = new sqlite3.Database(':memory:')

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

export { db, run, each };
