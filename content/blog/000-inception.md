+++
title = '000 - Inception'
date = '2026-09-06'
draft = false
+++
## I'm not a developer

I work on the infrastructure side of things in a big Italian company. My colleagues and I are working in what I would define as an on-premises Kubernetes shop. We run almost everything on it.

I'm not a developer, but I have written code. Mostly small incomplete side projects, several prototypes for algorithms or ideas that occurred to me during my PhD and, recently, lots of automation scripts and small tools for my daily job.

I have a great deal of respect for top-class developers. Linus Torvalds, Salvatore Sanfilippo, Casey Muratori, Jonathan Blow, David Heinemeier Hansson, Mitchell Hashimoto. They are the people I read and listen to the most in the software realm, especially now with the AI wheel spinning at this unbearable pace.

I have developed a passion for minimalism and performance. There is something inspiring about watching Casey write a 3D game from scratch in C using Emacs. And I find it fascinating to read the code and the write-up of kilo from Salvatore. *The pursuit of excellence does not need justification*, as Mitchell recently wrote, and honestly, it is a marvel to watch all of them succeed in such efforts.

I find it kind of funny: I like minimalism but I ended up working in the most bloated ecosystem out there. They call it cloud native, and I hate that term. Take a look at the [CNCF Landscape](https://landscape.cncf.io/) if you don't know what I'm talking about. I love how the primitives of Kubernetes alone, in an on-premises scenario, allow you to build a completely open Software Defined Data Center. I hate it when a bunch of consultants knock at your door saying that in order to deploy their small app you first need to install 10M lines of code worth of CNCF projects. "Don't worry, they are just a couple of Helm charts to be installed, all cloud native good stuff." I find it sickening how even if you want to develop the simplest internal webapp for 1000 users in your company, you suddenly need the stack of X, Meta or Google because otherwise it won't scale. Fuck that, [Grug](https://grugbrain.dev/) for the win, complexity bad, complexity very bad. I guess that my love-hate relationship with Kubernetes will deserve an in-depth post later on.

## Software dreams

This tension between working in an overly bloated environment and liking minimalism forces me to constantly spend countless hours reading docs, assessing the architecture and peeking into the codebases of projects we could adopt to meet one of our company's needs. I try to dive deep, as much as my working hours and spare time allow, and as far as my understanding goes, in order to find out if there is a there there.

After 5 years of this exercise, I find myself in the strange position of having some software ideas even without having developed a serious software project with my own hands. I find myself daily asking for missing features in existing OSS projects or dreaming about solutions tailored around my use case or with a specific architecture or different user ergonomics so that they would fit my taste better. I have tried to implement a few of the things that came to my mind, but either the lack of time, the lack of motivation or the lack of competence always leaves me with nothing more than prototypes, draft documents or random brainstorming discussions on GitHub or Reddit.

Let me tell you, since the launch of ChatGPT my software rants have escalated very quickly. Every time I have an idea, I now bounce it off that thing and it is like a drug. I really like to have someone that can assess the viability of an idea very quickly and that can do research to see if other projects already implement what's on my mind. And I love to draft the design documents for my dream software projects with that thing.

## Painful dreams

When really good models came out, I thought that all of a sudden I would be able to turn all my software dreams into reality. What I found out is that it is pretty darn difficult to come up with a complete design that makes sense. I usually start by describing very briefly the core of the idea, and then I try to work with the model in order to cover the design space and assess feasibility. I kid you not, more often than not, when the design is fully expanded it looks so messy and fragile that I throw everything away, realizing that maybe my genius idea was in the end not worth my tokens.

I do have to say, however, that out of tens of trials I was able to finish at least one useful project. It is a small migration tool that we used to successfully migrate all our 2000 k8s volumes from one storage solution to another, minimizing the downtime of the applications using them. I didn't find a tool that was doing exactly what I had in mind, so I built it from scratch using an on-premises instance of GLM 5.2.

In the process of building one useful thing and throwing away tens of stupid ideas expanded into messy designs, I have learned a couple of things.

First, asking an LLM for feedback on a sketchy idea is completely useless: those daemons love to tell you that you had a great intuition and that the idea is amazing. Start with a sketchy idea and then use the LLM to draft a detailed architecture before asking for feedback. If you put in the effort, you will see, after endless deep-dive sessions, why indeed Software Engineering is difficult.

Second, I feel like making good design decisions without having a good deal of experience is almost impossible. Moreover, locking down the design space is really difficult. Even for my successful project, I ended up making some critical decisions down the road and regretting some other design decisions made early on, since they would not allow a clean implementation of some other features. Since implementation is kind of cheap with a purely agentic approach, I find value in going back to the design phase after the first implementation, trying to add what I discovered to the design documents and having a second from-scratch implementation of the thing. I'm not sure something like this is viable for really large projects, but for small and probably medium-sized projects I think it is valuable to have multiple runs of implementation from scratch with different design decisions to see what works best and build experience.

Third, sometimes the model is able to steer me away from the original idea or to add random unrequested things to the design documents. When I review those designs either to assess them or out of pure curiosity, I am not sure anymore what was in the original idea and what was instead made up by the model. I actually still find value in clearly separating the original core human-developed idea from what comes next and is produced either by the model alone or by him and me together.

## Inception

I now usually start my software dreams with an INCEPT.md file open in a dead simple editor (mostly one of the vi reincarnations). I try to describe my ideas for the project there: the background story, references to the projects that inspired me, initial sketches or drafts for the architecture I have in mind. I avoid using an LLM in this phase since, as I have mentioned earlier, I find value in putting down my original idea before any brainstorming round with whatever oracle I have at hand.

I make sure to start the INCEPT.md file with a small sentence like *this file should be edited by humans and humans only. Autonomous agents can and should indeed read this document carefully since it represents the initial seed of the project.*

I then move on to creating an empty design folder and I spin up whatever harness I am using. At this point I instruct the model to read the INCEPT.md file and to start a brainstorming session with me. When the high-level design is clear, I ask the model to put it down in a design/00-high-level-design.md file. I then iterate over multiple sessions to dive deep into the design to create refined design/xy-whatever-subsystem.md documents. When I'm happy with the result, I spin up an implementation session that usually starts with "read the incept.md file and the design folder to get a grasp of the project. We will work on the implementation." I mostly stay in the loop asking directly what to implement first and how to move on. I do, however, want to experiment with a Ralph Wiggum loop over a co-authored implementation plan written beforehand.

What I really like about this workflow is the breadcrumb trail that it leaves behind. From the original seed of the idea, to the actual design of the internals with reasons behind each decision, to the actual implementation. I wish all the OSS projects had this kind of deep internal insight. I would read those kinds of documents and honestly they would make a hell of a training data set for LLMs.

# They say AGI is here

I started to use this workflow a few months back, and it is probably not too dissimilar from what other developers have adopted. Today lots of people would already question such an approach, saying that I spend way too much time being in the loop or I get involved in too many architectural decisions and that probably the model would already know better.

GPT-6, codename Astra, recently was released and quite smart people are starting to talk about an AGI era. I don't know how much to lean in that direction, but I have recently tried something that baffled me. I wanted a very minimalistic app to edit this very document you are reading. There are tons of writing apps for Android but I wanted something more aligned with my taste. I opened the ChatGPT app in work mode and I described it, asking it to come back with an installable apk to download. After a bit I heard the notification, downloaded the apk, installed the app, opened the app and started to use it to edit this very document.

I have to experiment more for sure, trying to ask for more complex and ambitious software. I think that the question that is on everybody's mind right now is whether this blind approach results in software that is actually good and robust. I don't think there is much value in asking such a question while loosing time on the code that the agents produce. Optimistic folks à la Peter Steinberger will just push back saying that more and later agents will eventually fix everything.

Right now, I think that probably the most sensible thing to do is simply try to build things and see if those things stick around. I would say that software is pretty unforgiving: if under the hood things are messy and not thought out, the resulting user experience will be bad and users will find a better competing alternative if there is one. I perfectly agree with Jonathan Blow about [the quality of software right now](https://youtu.be/FeAMiBKi_EM). We daily deal with crappy software, so if the AGI promise of producing amazing software out of a single prompt is grounded, we should very rapidly see that legacy crappy software being replaced by new software not pushed by large corporations but by single individuals who are not even developers but are simply users frustrated enough by the current state of things.

# Commit

I have issues committing to things outside my family and my work, so most of my side projects actually die out very fast. I will try to commit to writing at least one post per month until 2027. Then I'll try to ride the wave of New Year's hopes into committing myself for the whole of 2027. Those should be a grand total of 5 posts. Come on, Marco, you can do it.
