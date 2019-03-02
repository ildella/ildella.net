---
title: Parse a large text file using Node.js streams
date: 2019-03-02 12:50:19
tags:
---

The excercise is to parse a large structured text file of 'around' 3TB. 

We use only Node.js builtin **modules** and **streams** support.

We also use [Highland.js](http://highlandjs.org/) library for an elegant way to work with Streams. The library is not required but make the work much easier and drive us to an elegan way of writing code for this kind of tasks. Also is dependency free and written by [Caolan](https://github.com/caolan) who also built the more famous [async](https://github.com/caolan/async) utility.

## The objective

We will show that using streams, this task is 

1. Solved in a concise, clear and elegant way
2. Use minimal libraries that can easily be replaced, instead of using dangerous packages with tons of depencencies we can't control
3. Can parse a huge data file without memory problems of any kind, and pretty fast as well. 

Let's code.

## Connect to the file stream

We use builtin `fs` module to connect to the stream and builtin `readline` to read one line at a time in an elegant and reliable fashion

```javascript
const fs = require('fs')
const readline = require('readline')
const inputStream = fs.createReadStream('data/input-sample')
const rl = readline.createInterface({input: inputStream})
```

## The Generator

We combine `readline` module and `highland` to create an highland generator that pushes lines from readline for further processing.
Highland source can be an *array*, a *stream* or a custom **Generator**. We need this last one.

```javascript
const generator = (push, next) => {
  rl.on('line', line => {
    counter++
    push(null, line)
  })
  rl.on('close', () => {
    push(null, __.nil)
  })
}
```

## A simple line counter

```javascript

```

## Solution for the first 2 questions

```javascript
const countWithReadline = () => {
  __(generator)
    .filter(line => {
      return counter == 432 || counter == 43243
    })
    .map(line => `value at line ${counter}: ${line.split('|')[7]}`)
    .done(() => console.log(`Highland> line count: ${counter}`))
}
```

## Next

In the following article I will complete the other two tasks of the excercise and show some performance stats.