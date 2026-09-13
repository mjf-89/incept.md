+++
title = '001 - Inception'
date = '2026-09-11'
draft = true
+++
## I'm not a developer 

I work on the infrastructure side of things in a big Italian company. Me and my colleagues are working in what I would define an on-premise Kubernetes shop. We run almost everything on it. 

I'm not a developer, but I have written code. Mostly small incomplete side projects, several prototypes for algorithms or ideas occured during my PhD and recently lots of automation scripts and small tools for my daily job.

I have a great deal of respect for top class developers. Linus Torvalds, Salvatore Sanfilippo, Casey Muratori, Jonathan Blow, David Heinemeier Hansson, Mitchell Hashimoto. They are the people I read and listen the most in the software realm, especially now with the AI wheel spinning at this unbearable pace.

I have developed a passion for minimalism and performance. There is something inspiring watching Casey writing a 3D game from scratch in C using emacs. And I find it fascinating to read the code and the write up of kilo from Salvatore. *The pursuit of excellence does not need justification*, as Mitchell recently wrote, and honestly, is a marvel to watch all of them succeed in such effort. 

I find it kind of funny, I like minimalism but I ended up working in the most bloated ecosystem out there. They call it cloud native, and I hate that term. Take a look the [CNCF Landscape](https://landscape.cncf.io/) if you don't know what I'm talking about. I love how the primitive of Kubernetes alone, in an on-premise scenario, allow you to built a completely open Software Defined Data Center. I hate when a bunch of consultats knock at your door saying that in order to deploy their small app you first need to install 10M lines of code worth of CNCF projects. "Don't worry, they are just a couple of helm chart to be installed, all cloud native good stuff". I find it sickening how even if you want to develop the most simple internal webapp for 1000 users in your company you suddenly need the stack of X.com, meta or google because otherwise it won't scale. Fuck that, [Grug](https://grugbrain.dev/) for the win, complexity bad, complexity very bad. I guess that my love and hate relationship with kuberneres will deserve an in-depth post later on.

## Software dreams

This tension of working far off into an over bloated environment and liking minimalism forces me to constantly spend countless hours reading docs, assessing the architecture and peeking into the codebase of projects we could adopt to solve one of our company needs. I try to dive deep, as much as my working hours and spare time allow, and as much as my understanding goes in order to find out if there is a there there. 

After 5 years of such exercise I find myself in the strange position of having some software ideas even without having developed a serious software project with my own hands. I daily find myself asking for missing features into existing OSS projects or dreaming about solutions tailored around my use case or with specific architecture or different user ergonomics so that they would fit my taste better. I have tried to implement few of the things that came to my mind but either the lack of time, the lack of motivation or the lack of competence always leave me with nothing more then prototypes, drafts documents or random brainstorming discussions into GitHub or Reddit.

Let me tell you, since the launch of ChatGPT my software rants escalated very quickly. Every time I have an idea I now bounce it off with that thing and it is like a drug. I really like to have someone that can assess the viability of an idea very quickly and that can do research to see if other projects already implement what's on my mind. And I love to draft the design documents for my dream software projects with that thing. 

## Painful dreams

When really good models come out I thought that all of a sudden I would be able to turn all my software dreams into reality. What I found out is that it is pretty darn difficult to come up with a complete design that makes sense. I usually start describing very briefly the core of the idea, and then I try to work with the model in order to cover the design space and assess feasibility. I kid you not, most often then not, when the design is fully expanded it looks so messy and fragile that I throw everything off understanding that maybe my genius idea was in the end not worth my tokens. 

I do have to say however that out of tens of trials I was able to finish at least one useful project. It is a small migration tool that we used to successfully migrate all our 2000 k8s volumes from one storage solution to another minimizing the downtime of the applications using them. I didn't find a tool that was doing exactly what I had in mind so I built it from scratch using an on-premise instance of GLM 5.2. 

In the process of building one useful thing and throwing away tens of stupid ideas expanded into messy designs I have learned a couple of things. 

First, asking for feedback to an LLM out of a sketchy idea is completely useless, those daemons love to tell you that you had a great intuition and that the idea is amazing. Start with a sketchy idea and then use the LLM to draft a detailed architecture before asking for feedback. If you put in the effort, you will see, after endless deep dive session, why indeed Software Engineering is difficult. 

Second, I feel like taking good design decision without having a good deal of experience is almost impossible. Moreover locking down the design space is really difficult. Even for my successful project I ended up taking some critical decision down the road and  regretting some other early on design decision since they would not allow a clean implementation of some other features. Since implementation is kind of cheap with a purely agentic approach I find value in going back to the design phase after the first implementation, trying to add what I discovered to the design documents and having a second from-scratch implementation of the thing. I'm not sure something like this is viable for really large projects, but for small and probably medium size project I think it is valuable to have multiple runs of implementation from scratch with different design decision to see what works best and build experience.

Third, sometimes the model is able to steer me off the original idea or to add random unrequested things in the design documents. When I review those designs either to assess them or out of pure curiosity I am not sure anymore of what was in the original idea and what was instead made up by the model. I actually still find value in clearly separating the original core human developed idea from what come next and it is produced either by the model alone or by him and me together. 

## Inception workflow

I now usually start my software dreams with an INCEPT.md file open in a dead simple editor (mostly one of the vi reincarnations). I try to describe there my ideas for the project, the background story, references for the projects that inspired me, initial sketches or drafts for the architecture I have in mind. I avoid using an LLM in this phase since, as I have mentioned earlier, I find value in putting down my original idea before any brain storming round with whatever oracle I have at hand.

I make sure to start the INCEPT.md file with a small sentence like *this file should be edited by humans and humans only. Autonomous agents can and should indeed read carefully this document since it represent the initial seed of the project.

I then move on creating an empty design folder and I spin whatever harness I am using. At this point I instruct the model to read the INCEPT.md file and to start a brain storming section with me. When the high level design is clear I ask the model to put it down in a design/00-high-level-design.md file. I then iterate over multiple sessions to dive deep into the design to create refined design/xy-whatever-subsystem.md documents. When I'm happy with the result I spin up an implementation session that usually starts with "read the incept.md file and the design folder to have a grasp on the project. We will work on the implementation." I mostly stay in the loop asking directly what to implement first and how to move on. I want however to experiment with a Ralph Wiggum loop over a co-authored implementation plan written before hand. 

What I really like of this workflow is the breadcrumbs trail that leave behind. From the original seed of the idea, to the actual design of the internals with reasons behind each decision to the actual implementation. I wish all the OSS projects had this kind of deep internal insights. 
