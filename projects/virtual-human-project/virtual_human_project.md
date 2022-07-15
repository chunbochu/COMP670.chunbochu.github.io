# COMP 670 Virtual Human Project
## Introduction
The Virtual Human Project is a team-based hands-on exercise to build a conversational AI assistant (chatbot). AI chatbots are right on the front lines of artificial intelligence and human intelligence. In this project, you will learn a very exciting tool: [Rasa Open Source](https://rasa.com/open-source/) to build your own chatbot. Rasa is a popular open source deep learning framework for chatbot. It supplies the building blocks for creating virtual assistants: Natural Language Understanding, Dialogue Management, and Integrations.

## Resources
### Recommended readings/book:
- [Rasa Learning Center](https://learning.rasa.com/): This is a great place to learn Rasa. Tons of useful resources. Docs are updated to Rasa 3.x
- [Rasa's Official Documents](https://rasa.com/docs/rasa/)
- [Conversational AI with Rasa: Build, Test, and Deploy AI-powered, Enterprise-grade Virtual Assistants and Chatbots](https://learning.oreilly.com/library/view/-/9781801077057/?ar). Xiaoquan Kong, Guan Wang. Packt Publishing, 2021. ISBN	1801077053, 9781801077057. This book is free to access via your Franklin account.
  - This is a good reference book with in-depth coverage. It has some out-of-date information of Rasa though. You should use it along with Rasa's official documents above.
  - Focus on *Section 1: The Rasa Framework* to have a good understanding of the fundamentals of the framework. It includes:
    - Chapter 1, Introduction to Chatbots and the Rasa Framework
    - Chapter 2, Natural Language Understanding in Rasa
    - Chapter 3, Rasa Core
### Rasa server
We have created a server with Rasa Core and Rasa X installed. You can build, train and deploy your bot on it. Please read the [Rasa Server Docment](https://docs.rasa.cs.franklin.edu/) to learn how to create your bot on it.


## Project Requirements
Your team must build a non-trivial, task-oriented chatbot that aims to help users achieve a particular task.

Generally, conversational agents can be classified as *chit-chat bots*, which are chatbots destined for the sole purpose of maintaining a conversation, being interesting, creative or fun, and *task-oriented chatbots* which offer customer support or act as personal assistants, helping users to achieve a certain task.
Ref: [Chatbot Categories and Their Limitations](https://dzone.com/articles/chatbots-categories-and-their-limitations-1#:~:text=The%20first%20classification%20splits%20the,to%20achieve%20a%20certain%20task.)

- Must use [forms](https://learning.rasa.com/conversational-ai-with-rasa/basic-forms/) to collect user's input
- Must use [slots](https://learning.rasa.com/conversational-ai-with-rasa/slots/)


## Tasks and Deliverables
### Task 1: Tooling and Basic NLP knowledge
By end of Week 2: your team should complelte the following:
  - read "Introduction to Natural Language Processing (NLP)", "Chatbot basics" in the book
  - started [Conversational AI with Rasa](https://learning.rasa.com/conversational-ai-with-rasa/introduction-to-rasa/)
  - log in to the Rasa server to get familiar with the development environment
  - create and train a default bot
  - set up an html page with your initial bot connected. We will use the Web channel. You are welcome to explore using other channels (Facbook, Telegraph, etc.) but not required.
  - explore the interface and functioinalities of Rasa X
### Task 2: 
By end of Week x: your team should complelte the following:
  - [Conversational AI with Rasa](https://learning.rasa.com/conversational-ai-with-rasa/introduction-to-rasa/)
  - brainstorm the purpose of your bot, what is the task it's going to accomplish.
  - compose a report

### Deliverables
- A zip file including all of your bot training YMAL files: `domain.yml`, `stories.yml`, `policy.yml`, `rules.yml`, `endpoints.yml`, `config.yml`

[Measuring success](https://rasa.com/blog/using-conversation-tags-to-measure-carbon-bots-success-rate/)

It won't be surprising to anyone who's built an AI assistant that measuring success can be subjective. Success can mean a lot of different things:
- Did the assistant correctly classify a message's intent and extract the right entities?
- Was the right response selected?
- Was the user's sentiment positive?
- Did the assistant help the user achieve their goal?
