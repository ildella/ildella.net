---
title: Parse a large text file using Node.js streams
tags:
  - nodejs
  - streams
  - highlandjs
  - programming
  - data-processing
  - text-files
date: 2019-03-02 12:50:19
---


Problem and solution: parse and query a large structured 3GB text file.

{% asset_img "cover.svg" "Highland Generator from readline" %}

<!-- more --> 

## Background

Last fall I was browsing the Web and I did stumbled upon this [article](https://itnext.io/using-node-js-to-read-really-really-large-files-pt-1-d2057fe76b33) which poses a problem and describes a solution. 

I did not like the solution that much, so I wrote another one. 

## The Problem

If you do not want to read the [original article](https://itnext.io/using-node-js-to-read-really-really-large-files-pt-1-d2057fe76b33), it's about reading from [this ~3GB structured text file](https://www.fec.gov/files/bulk-downloads/2018/indiv18.zip) which is made up by lines like this one:

```
C00630012|A|M5|P|201805259113613843|15|IND|ZUCKER, JONATHAN|WASHINGTON|DC|200011801|DEMOCRACY ENGINE LLC|CEO|04282018|0||13603068|1234609||EARMARKED FOR H-AL-05-D NOMINEE FUND 2018|4053020181570483883
```

The challenge is to perform query operations on the file. The real challenge of course is that the file can't be loaded in memory as a whole, so something clever should be put in action. 

## The objective

We use Node.js builtin modules and **streams** support.

We also use [Highland.js](http://highlandjs.org/) which offer an elegant way to work with Streams. The library is *not required* to solve this properly, but makes the work easier and drive to an elegant way of writing code for this kind of tasks which is useful for more complicated situations.

Highland is *dependency free* and is written by [Caolan](https://github.com/caolan), who also built the more famous [async](https://github.com/caolan/async) utility.

Let's code.

## Connect to the file stream

We use builtin `fs` module to connect to the stream and builtin `readline` to read one line at a time in an elegant and reliable fashion

```javascript
const fs = require('fs')
const readline = require('readline')
const inputStream = fs.createReadStream('data/input-sample')
const rl = readline.createInterface({input: inputStream})
```

Now we can pipe the stream in an Highland stream. Let's see how.

## The Generator

Highland source can be an *array*, a *stream* or a custom **Generator**. We need this last one. We combine `readline` module to reliably read lines of text and then them into an `highland` stream. 

Finally, we properly terminate the Highland stream. 

```javascript
const generator = (push, next) => {
  rl.on('line', line => {
    push(null, line)
  })
  rl.on('close', () => {
    push(null, __.nil)
  })
}
```

## A simple line counter (1st question)

With all of the above set, counting lines of a very large file is a breeze:

```javascript
const __ = require('highland')
const countLines = () => {
  __(generator)
    .tap(() => counter++)
    .done(() => console.log(`line count: ${counter}`))
}
```

## Solution for the 2 questions

We are asked to find the value for the 7th column at lines 432 and 43243.

```javascript
const __ = require('highland')
const valuesAtLines = () => {
  __(generator)
    .tap(() => counter++)
    .filter(line => {
      return counter == 432 || counter == 43243
    })
    .map(line => line.split('|')[7])
    .map(value => `value at line ${counter}: ${value}`)
    .toArray(array => console.log(array))
}
```

So elegant right? There is no need to explain it. 

Try to imagine the avarage solution you normally see for this kind of problems: how many `if` and `for` can you picture? Exactly. 

This code is wonderfull because is written in sequence, which makes it **readable**, but works on streams, which makes it **scalable**.

The two `map()` could be merged in one of course, but I find it more clear and more educational to have 2 different mapping. The first is data decomposition, the second is output formatting. It also clearly shows the power of Highland in describing data processing pipelines. 

## Conclusion

1. The problem is solved in a concise, clear and elegant way
2. There is minimal to no external libraries involved, and we do not pollute our software with back packages with tons of dependencies
3. It's easy to parse a large data file without memory problems of any kind, and pretty fast as well. 

## Next

In the following article I will complete the other two questions of the excercise and show some performance stats.
