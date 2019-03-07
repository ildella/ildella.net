---
title: Parse a large text file using Node.js streams - part 2
tags:
  - nodejs
  - streams
  - highlandjs
  - programming
  - data-processing
  - text-files
date: 2019-03-07 07:56:25
---


Have a look at the [part 1](/2019/03/02/parse-large-text-file-with-nodejs-streams) for the necessary context. Here we go.

## Question: count the name occurrences

We need to identify the most common first name in the data and how many times it occurs.
Map/reduce is convenient here, the name is in the column 8, so we isolate the column than accumulate te occurrences in an object. 

```javascript
const occurrences = {}
const namesOccurences = () => {
  __(generator)
    .map(line => line.split('|')[8])
    .reduce(0, (a, name) => {
      occurrences[name] = (occurrences[name] || 0) + 1
      return name
    })
    .done(() => {
      console.log('Highland> names occurrences:')
      console.log(occurrences)
    })
}
```

## Question: donations per month

Count how many donations occurred in each month and print out the results. The donation amount is in the column 5. 

This time we extract the reduce function for more clarity:

```javascript
const accumulator = {}
const sumByMonth = function (a, item) {
  accumulator[item.month] = (accumulator[item.month] || 0) + 1
  return item
}

const countDonationsPerMonth = () => {
  __(generator)
    .map(line => { return {month: line.split('|')[4].substring(4, 6), line: line,}})
    .reduce(0, sumByMonth)
    .done(() => {
      console.log('Highland> donations per month:')
      console.log(accumulator)
    })
}
```

## Considerations

The hardest part of this 2 questions was building the reduce function, which requires some ~~research on Stackoverflow~~ serious knowledge.

The rest is easy, clear, readable, reliable and fast thanks to Streams and Highland. 

## Conclusions. 

A complete working example is in this [Github repo](https://github.com/ildella/learn-tests-brokenthings/blob/master/nodejs/src/exercise-large-text-file-highland.js). 

Would love feedback. 
Is the topic interesting? The solution nice? Would you like to read more about Streams or Highland? Or how to avoid lodash and use EcmaScript properly? 

I do not have a comment section here but [Twitter](https://twitter.com/ildella) is perfect.

Have a lovely day. 