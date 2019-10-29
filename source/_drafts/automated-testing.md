---
title: Automated Testing
tags: testing, automation, tdd
---

**Functional and Performance** are orthogonal to **Unit and E2E**.  It means we have Functional and Performance at both Unit and E2E level.  Functional test the “correctness” and performance the “fast/scalable”. 

| **Unit**                                                     | **End 2 End**                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Isolated**: depend only on the the file/class/service.     | Test the whole system. All of it.                            |
| **Faster**: tens/hundreds of ms each / max 5 secs a package suite. | Slower, now slow. Too slow ==> change the tool, the test implementation or improve the system. |
| **Continuous**: Runs in dev machines and on shared pipelines all the time. | Run against running instance of the whole system (aka: cluster or mesh) |
| **For Devs**: written and owned 100% by devs                 | Written and owned by Product/QA/Devs together. Represents the specs. |
| **Green means deploy**: grant builds to be pushed to Cluster | Grant systems to be promoted to next environment stage.      |
|                                                              |                                                              |

Bottom line: I do not think that integration tests, as commonly intended as the “medium level”, are really necessary.

## Some clarifications

### How isolated

They do not depend on databases, cloud services, queues, environment variables or any other service that does not run in the same "server" (node, pod, instance, process...)

In a Microservice architecture, each service is treated exactly like an external system. It must be mocked. 

### Integration tests are not a thing

That's bold right? 

Unit tests with mocks are enough to test the whole "service" functionality and performance. 

Most services will use some external systems, that are 100% mocked. One should not test other systems functionalities or performance, if not in a discovery phase that has nothing to do with this topic. 

I am willing to make a Q&A session on this very topic, but there is no real use of "integration tests". It's either something that should be mocked and done as a Unit Test, or something that will be covered in E2E test. 

### But E2E tests are too expensive

Well, that's your fault. If delivering an isolated service and running a test against it using the whole system is "too much", the solution is not complicating the testing as well, rather improve your system. 

### Performance tests and unite tests?  

Yes, why not? If you think it should be critical for a component to answer fast in certain condition, it should be in a unit test as well. It is almost always possible to write a small-scale version of a performance e2e test. As always, it's the combination of Unit/E2E that will give you confidence, still the Unit test lifecycle is much faster, and also being able to test some level of the performance at the unit test meanse that the code is really good. 

### I think this is too extreme

Well, that's something that is said by people that also say "It's ok, but unfortunately for us"... And you know they are wrong. 

Let's make another example. 

The bottleneck of many services is the query to the database... that's something that must be addressed when writing the code. That means, whilst writing the unit tests.

You should write a mock for the DB that is slow, or that dies when it receives too many requests at the same time. Leaving this to E2E tests is just lazy. 

The limitations of the external systems are an integral part of the work of building a service, and should be  discovered in the exploration stage, and consolidated in tests and in mocks. 

### But then why E2E at all? 

Glad you asked. In this framework, E2E tests are not there mostly to consolidate specs with non-devs, test that all pieces are working together nicely. Is very hard that all feature specifications are tested thoroughly both at unit level and at E2E level. 

