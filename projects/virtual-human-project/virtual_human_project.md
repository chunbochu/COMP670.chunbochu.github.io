# COMP 670 Virtual Human Project
## Introduction
The Virtual Human Project is a team-based hands-on exercise to build a conversational AI assistant (chatbot). AI chatbots are right on the front lines of artificial intelligence and human intelligence. In this project, you will build your own chatbot with a very exciting tool: [Rasa Open Source](https://rasa.com/open-source/). Rasa is a popular open source deep learning framework for chatbot. It supplies the building blocks for creating virtual assistants: Natural Language Understanding, Dialogue Management, and Integrations.

## Resources
### Recommended readings/book:
- [Rasa Learning Center](https://learning.rasa.com/): This is a great place to learn Rasa. Tons of useful resources and videos. Docs are updated to Rasa 3.x
- [Rasa's Official Documents](https://rasa.com/docs/rasa/)
- [Conversational AI with Rasa: Build, Test, and Deploy AI-powered, Enterprise-grade Virtual Assistants and Chatbots](https://learning.oreilly.com/library/view/-/9781801077057/?ar). Xiaoquan Kong, Guan Wang. Packt Publishing, 2021. ISBN	1801077053, 9781801077057. This book is free to access via your Franklin account.
  - This is a good reference book with in-depth coverage. However, it has some out-of-date information of earlier versions of Rasa. You should use it along with Rasa's official documents above.
  - Focus on *Section 1: The Rasa Framework* to have a good understanding of the fundamentals of the framework. It includes:
    - Chapter 1, Introduction to Chatbots and the Rasa Framework
    - Chapter 2, Natural Language Understanding in Rasa
    - Chapter 3, Rasa Core
### Rasa server
We have created a server with Rasa Core and Rasa X installed. You can build, train and deploy your bot on it. Please read the [Rasa Server Docment](https://docs.rasa.cs.franklin.edu/) to learn how to create your bot on it.

You will drop to your default home directory after logging in with your individual account. You should run
 `cd /opt/bots/<team[1|2|...]>` to switch to your team directory. You bot should be created, trained and maintained there.
A unique pair of port numbers will be assigned to each team by your professor in class. Please only run your Rasa and Rasa X servers on your assigned ports to avoid conflicts.

Please create your team project bot in your **team** directory.


## Project Requirements

Generally, conversational agents can be classified as *chit-chat bots*, which are chatbots destined for the sole purpose of maintaining a conversation, being interesting, creative or fun, and *task-oriented chatbots* which offer customer support or act as personal assistants, helping users to achieve a certain task.
Ref: [Chatbot Categories and Their Limitations](https://dzone.com/articles/chatbots-categories-and-their-limitations-1#:~:text=The%20first%20classification%20splits%20the,to%20achieve%20a%20certain%20task.)

Your team will use Rasa Open Source to build a non-trivial, task-oriented chatbot that aims to help users achieve a particular task. Your professor will announce the task for your bots.
Your implementation should
- use [forms](https://learning.rasa.com/conversational-ai-with-rasa/basic-forms/) to collect user's input
- use [slots](https://learning.rasa.com/conversational-ai-with-rasa/slots/)


## Tasks and Deliverables
### Task 1: Team Formation, Tooling and Basic NLP knowledge
Your team should complete the following:
  - read "Introduction to Natural Language Processing (NLP)", "Chatbot basics" in the book
  - started [Conversational AI with Rasa](https://learning.rasa.com/conversational-ai-with-rasa/introduction-to-rasa/)
  - log in to the Rasa server to get familiar with the development environment
  - create and train a default bot (see below)
  - set up an html page with your initial bot connected. We will use the Web channel. You are welcome to explore using other channels (Facbook, Telegraph, etc.) but not required (see below)
  - explore the interface and functioinalities of Rasa X

There are many resources on creating chatbots with Rasa. [Building a Chatbot with Rasa](https://towardsdatascience.com/building-a-chatbot-with-rasa-3f03ecc5b324) may help you get started.

#### How to create and train a default bot?
In your home directory on the Rasa server, run `rasa init` to reate a new project with example training data, actions, and config files. 

Next, run `rasa train` to train your initial bot. It may take a few minutes.

When the training finishes, run `rasa shell` to load your trained model. You talk to your assistant on the command line.

See more about [Command Line Interface](https://rasa.com/docs/rasa/command-line-interface).

#### How to integrate the chatbot in your website?
Review the following docs first:
 - [Website Integration](https://learning.rasa.com/conversational-ai-with-rasa/website-integration/)
 - [Your Own Website](https://rasa.com/docs/rasa/connectors/your-own-website/)

Each team will be assigned a unique port number to run your rasa server on. You must use the assigned port to avoid conflicts with other teams.
You should have a `public_html` folder created in your account. If not, you just have to run `mkdir ~/public_html` to create it.
Then do the following:
 - `cd public_html`
 - `nano index.html` and copy the following:
  ```html
<!doctype html>
<html>
<head>
<title>My Chatbot Page</title>
</head>
<body>
<script>!(function () {
  let e = document.createElement("script"),
    t = document.head || document.getElementsByTagName("head")[0];
  (e.src =
    "https://cdn.jsdelivr.net/npm/rasa-webchat/lib/index.js"),
    // Replace 1.x.x with the version that you want
    (e.async = !0),
    (e.onload = () => {
      window.WebChat.default(
        {
          customData: { language: "en" },
          socketUrl: "https://{port}.rasa.cs.franklin.edu/",
		  //title: "Chunbo's bot",
          // add other props here
	  initPayload: "Hey Rasa!",
		params: {storage: "session"},
        },
        null
      );
    }),
    t.insertBefore(e, t.firstChild);
})();
</script>
</body>
</html>
  ```
Note that you must replace `{port}` in `socketUrl` with your assigned port number.
- Save the file and exit nano.
- To use the web chat widget, SocketIO channel must be configured by adding the credentials to your `credentials.yml`:
```yaml
socketio:
  user_message_evt: user_uttered
  bot_message_evt: bot_uttered
  session_persistence: true/false
```
- Start your rasa server: `rasa run --enable-api --debug --cors="*" --port {port}`
- Open a browser to visit `https://rasa.cs.franklin.edu/~username` to verify the bot is connected.

### Task 2: 
Your team should complete the following:
  - [Conversational AI with Rasa](https://learning.rasa.com/conversational-ai-with-rasa/introduction-to-rasa/)
  - brainstorm the purpose of your bot, the task it is going to accomplish, the domain knowledge it has, external data source/API may be needed; etc.
  - compose a report to submit.

### Task 3:
Your team should complete the following:
  - regularly review and tag conversation data via Rasa X
  - develop your own application server if needed
  - constantly train and test your bot
  - Review the following:
	  - [Conversation-Driven Development](https://rasa.com/docs/rasa/conversation-driven-development)
	  - [Testing Your Assistant](https://rasa.com/docs/rasa/testing-your-assistant)
	  - [Setting up CI/CD](https://rasa.com/docs/rasa/setting-up-ci-cd)
 
### Task 4:
Your team should complete the following:
  - identify at least one Virtual Human agent deployed by other teams
  - interact with the agent and evaluate its performance

Read how to [Measuring success](https://rasa.com/blog/using-conversation-tags-to-measure-carbon-bots-success-rate/)
It won't be surprising to anyone who's built an AI assistant that measuring success can be subjective. Success can mean a lot of different things:
- Did the assistant correctly classify a message's intent and extract the right entities?
- Was the right response selected?
- Was the user's sentiment positive?
- Did the assistant help the user achieve their goal?

### Task 5:
Your team should complete the following:
- Submit a final report
- Submit the following deliverables
	- A zip file including all of your bot training YAML files: `nlu.yml`, `domain.yml`, `stories.yml`, `policy.yml`, `rules.yml`, `endpoints.yml`, `config.yml`
