```
$ git tag
v0.1
v1.3

$ git tag v1.4
$ git tag
v0.1
v1.3
v1.4

// コミットを指定して後からタグ付けも可能
$ git tag v1.2 9fceb02
$ git tag
v0.1
v1.3
v1.2
v1.4
```
