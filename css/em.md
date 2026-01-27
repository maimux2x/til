## em とは何か

その要素の font-size を基準にした相対単位

```css
p {
  font-size: 16px;
  margin-top: 2em; /* = 32px */
}
```

この場合、
- 1em = p の font-size = 16px
- 2em = 32px

### 基準は親ではなくその要素自身

```css
div {
  font-size: 20px;
}

p {
  font-size: 1.5em;
  margin-bottom: 1em;
}
```

1. p の font-size
- 1.5 em x 親(div)の20px 
  - 30px
- `margin-bottom: 1em`
  - 1em = p 自身の font-size = 30px

font-size が未指定の場合、最終的に `body/html` の font-size にいきつく。
多くのブラウザでデフォルトのフォントサイズは 16px のことが多い。
