# Loanstreet Platform Project
## Overview

The team at Loanstreet is onboarding a new application, and the developers need help getting started.  They're looking to you to build out a robust local toolchain that allows them to share code updates quickly between developers.

***PLEASE DO NOT WORK MORE THAN SIX HOURS ON THIS PROJECT***

---

## Requirements

The project as defined has three phases, each of which should take 1-2 hours.  Given the time constraints, its recommended to take the simplest path to the objective, but individual technology choices are left to the candidate.

Take this opportunity to show us how you work!

* Phase 1 - Bootstrapping the local environment
* Phase 2 - Role-based Scenarios
* Phase 3 - Deployment

***PLEASE DO NOT SUBMIT CHANGES TO THIS REPO.  FORK THE REPO AND SEND US THE LINK***

---

## Roles

At Loanstreet, the Platform team has several roles.  Each role represents an area of focus for our team.  In Phase 2 and Phase 3, you will be asked to pick one of the following roles for the remainder of the project:
1. Developer Advocate - Help advocate for and improve the developer experience.  Focuses on velocity, instrumentation, and tooling
2. Architect - Help build solid infrastructural foundations for our application stack.  Focuses on Cloud architecture, redundancy, Disaster Recovery, scaling, and generally setting the infrastructure up for success.
3. Security Engineer - Help ensure that infrastructure and applications meet compliance targets and provide strong semantic security (not always the same thing!)

---

## Project

You'll find the outline for each phase of the project below.  Each phase should take roughly 1-2 hours.  Bring your experience, problem solving skills, and technical expertise to bear and show us what you can do!

---

### Phase 1

- [Provided Solution](Phase_1.md)

The first thing our new development team needs is a way to standardize their local dev environments.  The team is already using tools like Spring boot, docker, and gradle to simplify the build and packaging process.

They've sent you the following instructions for getting the application running yourself:

```bash
./gradlew bootJar
./gradlew bootBuildImage
docker run platform-interview:0.0.1-SNAPSHOT --p '8080:8080'
```

However, the developer who passed you this information noted that the docker command is not working for her locally.  She thinks this is a problem with the command the application author gave her, but isn't sure.

One of the developers notes that they've heard tools like docker-compose and make can help with codebase management, but they have no experience using them.  They need your help to get this application running locally in a consistent way.

---

### Phase 2

- [Provided Solution](Phase_2.md)

You're getting a lot of praise now that the application is working consistently for the team.  They're very excited about their new tools, and have a number of follow on asks to distribute across the Platform Team.  Choose one of the options below and help them take their app to the next level!

### Developer Advocate

The development team is interested to see how their application is performing.  They've heard that tools like Prometheus and InfluxDB can be integrated into the application quickly and easily, and one of the devs notes that they'd love to start seeing request statistics.

Implement a new endpoint in the application that exposes requests per second.

### Architect

The development team has been making some big application changes with their new tools and are pretty excited to get to the next step.  They've heard that tools like Kubernetes can help them scale their application, but no one on the team has used it before.  They'd like to start playing around with container orchestration locally so that they're more familiar with these tools when they go to production.

Pick a container orchestration tool that's easy to set up both locally and in the cloud.  Implement a local single node version of your chosen platform that developers can use to "deploy" their changes locally.

### Security Engineer

Since Loanstreet is a finance company, there's a lot of concern on the team about security and privacy.  They're new to containers and want to make sure they're protecting client information at every level.

Implement OWASP best practices for docker containers.

---

### Phase 3

- [Provided Solution](Phase_3.md)

Now that the team has built some momentum, they're interested in pushing their application to production.  They're relying on you and the Platform team to guide their infrastructure decisions in a number of ways.

Pick from one of the follow on projects below, and outline how you would implement it.  Be sure to include a rationale for any technology choices you make and outline any decisions that need to be made early to ensure success.

### Developer Advocate

The complexity of our new application has grown dramatically since we started.  The developers have done a great job of choosing database and caching technologies, but now they're starting to hit performance and stability issues that they're not sure how to debug.

One of the senior devs recently attended a conference on observability (o11y) and suspects that a solid observability tool would help them make sense of application problems more scalably.  However, they've left the choice of o11y tools to you given your Platform Team expertise.

Your job is to choose a monitoring and metrics platform that will meet the development team's needs.  The company is open to both open source and paid options, and they've asked you to do some research on what we should choose.  The CTO has noted that they've used New Relic in the past, but haven't been entirely happy with it.

Build a case for your preferred platform.  Your analysis should include what you think the most important metrics will be for the new application (based on your discussions with the development team), and a brief rationale for the platform you chose.

### Architect

The team is ready to start pushing to production, but they're concerned about scale.  They've noted from local testing that each application backend can handle at most 500 requests / sec.  They're looking to you to help spread client load across multiple backends and implement some form of metrics-based autoscaling.

Write a rationale for expanding on your work in Phase 2.  How would you build out a platform on AWS that uses your container ochestrator of choice to scale workloads by number of requests?  Given this is a fairly involved request, a rationale or annotated diagram is sufficient (no code required).

Be sure to note the components needed to implement metrics based scaling since this work will be distributed across the team.

### Security Engineer

The team is ready to start pushing continuous updates to their application in production.  However, they've been adding a lot of additional application libraries and want to ensure they're not introducing vulnerabilities into the pipeline.  They've asked you to find a way to automate the detection of insecure libraries.  From your own experience, you know that the docker images the team is packaging are a potential risk as well.

Describe how you would set up and automate regular static code scans and docker image scans.  Describe how you would design this system such that vulnerable application artifacts don't make it to production.  Note that the resulting solution should be manageable by the application team once finished.

---

## Feedback (Optional)

Now that you've completed the exercise, we'd love to get some feedback from you regarding the process.  Please feel free to share your experience of completing the assessment, including anything that you think we could do better.  We will use this feedback to improve the technical assessment process for all candidates, and all feedback is valued and welcomed!

Finally, thank you for completing this exercise!
