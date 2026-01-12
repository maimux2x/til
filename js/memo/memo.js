import * as fs from 'node:fs';
import sqlite3 from 'sqlite3';
import minimist from 'minimist';

class MemoDatabase {
  constructor(dbPath = ':memory:') {
    this.db = new sqlite3.Database(dbPath);
  }

  init() {
    this.db.run("CREATE TABLE memo (id INTEGER PRIMARY KEY, body TEXT NOT NULL)");
  }

  save(memo) {
    this.db.run("INSERT INTO memo (body) VALUES (?)", memo);
  }

  close() {
    this.db.close();
  }
}

class Memo {
  constructor() {
    this.input = fs.readFileSync(0, 'utf8').trim();
    this.database = new MemoDatabase();
  }

  add() {
    this.database.init();
    this.database.save(this.input);
    this.database.close();
  }
}

let memo = new Memo();
memo.add()
console.log(memo.input);
