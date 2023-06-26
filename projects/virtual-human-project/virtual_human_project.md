# COMP 670 Virtual Human Project
## Introduction
The Virtual Human Project is a team-based hands-on exercise to build a conversational AI assistant (chatbot). AI chatbots are right on the front lines of artificial intelligence and human intelligence. In this project, you will build your own chatbot with [Rasa Open Source](https://rasa.com/open-source/). Rasa is a popular open source deep learning framework for chatbot. It supplies the building blocks for creating virtual assistants: Natural Language Understanding, Dialogue Management, and Integrations.

## Resources
### Recommended readings/book:
- [Rasa's Official Documents](https://rasa.com/docs/rasa/). Shorter, concise and easy to read. This is likely your go-to place of learning and reference. Docs are updated to Rasa 3.x
- [Rasa Learning Center](https://learning.rasa.com/): This is a great place to learn Rasa. Tons of useful resources and videos.
- [Conversational AI with Rasa: Build, Test, and Deploy AI-powered, Enterprise-grade Virtual Assistants and Chatbots](https://learning.oreilly.com/library/view/-/9781801077057/?ar). Xiaoquan Kong, Guan Wang. Packt Publishing, 2021. ISBN 1801077053, 9781801077057.
  - This book is free to access via your Franklin account. It is a good reference book with in-depth coverage. However, it has some out-of-date information of earlier versions of Rasa. You should use it as supplementary to Rasa's official documents above.
  - Focus on *Section 1: The Rasa Framework* to have a good understanding of the fundamentals of the framework:
    - Chapter 1, Introduction to Chatbots and the Rasa Framework
    - Chapter 2, Natural Language Understanding in Rasa
    - Chapter 3, Rasa Core
### Rasa server
Thanks to Franklin's IT support, especially Alex Kelly, we have our own server with Rasa 3.2.1 and Rasa X Community Edition installed so you don't have to deal with installing and configuring the tools. You can just build, train and deploy your bot on it. Please read the [Rasa Server Docment](https://docs.rasa.cs.franklin.edu/) to learn how to use the server.

#### Account
You will use your Franklin student's credential to log in after getting the okay from your professor.  Use an SSH client (e.g. running the `ssh your-username@rasa.cs.franklin.edu` command in Windows PowerShell) to log in. Your professor will also announce teams (typically 2 students per team) in class. You can explore the Rasa [CLI commands](https://rasa.com/docs/rasa/command-line-interface) in your own account and play around with your own bot by using `rasa shell`. However, each team should build, train and deploy their project bot in the team's directory.

#### Team directory
You will drop to your default home directory after logging in with your individual account. You should run  `cd /opt/bots/<team[1|2|...]>` to switch to your team directory. Your team's project bot should be created, trained and maintained there.

#### Assigned ports
A unique pair of port numbers (one for Rasa, the other one for Rasa X) will be assigned to each team by your professor. Please only run your Rasa and Rasa X servers on your assigned ports to avoid conflicts.

## Project Requirements
Generally, conversational agents can be classified as *chit-chat bots*, which are chatbots destined for the sole purpose of maintaining a conversation, being interesting, creative or fun, and *task-oriented chatbots* which offer customer support or act as personal assistants, helping users to achieve a certain task.
Ref: [Chatbot Categories and Their Limitations](https://dzone.com/articles/chatbots-categories-and-their-limitations-1#:~:text=The%20first%20classification%20splits%20the,to%20achieve%20a%20certain%20task.)

### Task
Your professor will announce the task for your bots. Your team will use Rasa Open Source to build a chatbot to achieve the task.
Your implementation should
- use [forms](https://learning.rasa.com/conversational-ai-with-rasa/basic-forms/) to collect user's input
- use [slots](https://learning.rasa.com/conversational-ai-with-rasa/slots/) to track information
 
You may also want to use the following:
- [Action Server](https://rasa.com/docs/action-server/)
- [Knowledge Base](https://rasa.com/docs/rasa/action-server/knowledge-bases/)
Programming in Python is needed.

## Activities and Deliverables

### Activitiy 1: Basic NLP knowledge and Rasa
You should complete the following:
 - individual:
   - watch [Conversational AI with Rasa](https://learning.rasa.com/conversational-ai-with-rasa/introduction-to-rasa/)
   - use the recommended learning resources to learn the basic concepts of Natural Language Processing (NLP) and Rasa, including: intent, entity, rasa training data, stories, rules, domain, actions, forms, slots, [Conversation-Driven Development](https://rasa.com/docs/rasa/conversation-driven-development)
   - log in our course Rasa server. Get familiar with the development environment and rasa [CLI commands](https://rasa.com/docs/rasa/command-line-interface)
 - team
   - create and train an initial bot (see below)
   - set up an html page with your initial bot connected (see below). We will use the Web channel to publish your bot. This is important for Conversation-Driven Development (CDD). You are welcome to explore using other channels (Facbook, Telegraph, etc.) but not required.
   - explore the interface and functioinalities of Rasa X

There are many resources on creating chatbots with Rasa. [Building a Chatbot with Rasa](https://towardsdatascience.com/building-a-chatbot-with-rasa-3f03ecc5b324) may help you get started.

#### How to create and train an initial bot?
In your team directory on the Rasa server, create a directory where your project will be save. For example: `mkdir bot`. Then, `cd bot`. Run `rasa init` to reate a new project with default training data and config files.
Next, run `rasa train` to train your initial bot. It may take a few minutes.
When the training finishes, you can talk to the bot on the command line by running `rasa shell`.
See more about [Command Line Interface](https://rasa.com/docs/rasa/command-line-interface).
Your team can go from there to build your bot solving the given task.

#### How to integrate the chatbot in your website?
There should be a `public_html` folder created in your team's home directory. If not, you just have to run `mkdir ~/public_html` to create it.
It's recommended to use an SFTP client , such as [SFTP for VSCode](https://marketplace.visualstudio.com/items?itemName=liximomo.sftp), [WinSCP](https://winscp.net/eng/index.php), to edit files on the server.
#### Step 1
Open the `index.html` in `public_html` and copy the following:
  ```html
<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<title>My Rasa Bot!</title>
<body>
	<div id="rasa-chat-widget" data-avatar-background="#d65cff" data-websocket-url="https://{rasa-port}.rasa.cs.franklin.edu/"></div>
	<script src="https://unpkg.com/@rasahq/rasa-chat" type="application/javascript"></script>
	
	<h2>Hey, this is COMP 670 <Team 1|2...> Virtual Assistant powered by Rasa!</h2>
	<p>If you send the first message but did not hear from the bot, my bot may be taking a "nap". 
	 Just resend your message. If the bot does not wake up, try refreshing your browser.</p>
	<h3>Hints to talk to the bot</h3>
	 <p>You may add other information to help your users chat with your bot, such as example questions, 
            what kinds of questions the bot can and cannot answer.</p>
	<h3>Release history and notes</h3> ...
</body>
</html>
  ```
**Replace `{rasa-port}` in `data-websocket-url` with your assigned Rasa server port number**

Save the file. You may want to style your `index.html` for better presentation.
#### Step 2
To use the web chat widget, the SocketIO channel must be configured. Uncomment the following section in your `/bot/credentials.yml` and set the values as:
```yaml
socketio:
  user_message_evt: user_uttered
  bot_message_evt: bot_uttered
  session_persistence: true/false
```
#### Step 3
Now start your rasa server: `rasa run --enable-api --debug --cors="*" --port {rasa-port}`.
Open a browser to visit `https://rasa.cs.franklin.edu/~<team1|2...>` to verify the bot is connected.

The following docs have more information for your reference:
 - [Website Integration](https://learning.rasa.com/conversational-ai-with-rasa/website-integration/)
 - [Your Own Website](https://rasa.com/docs/rasa/connectors/your-own-website/)

### Activity 2: 
Your team should complete the following:
  - based on the given task, discuss how your team wants to design and implement your bot. For example: what domain knowledge is needed, what type of questions should the bot answer, what data resource is available and how to source more data, should an action server and/or knowledgebase be used, how to test your bot, who are your potential users, how to manage the project and coordinate/communicate with team members, etc.
  - elect a Team Leader. The TL will submit deliverables of team tasks on behalf of the team. The TL will also serve as the "teach lead". For example, in case of disagreement between team members, the TL will make the decision.
  - compose an initial design report based on your team discussion and the Conversation-Driven Development (CDD) approach.
  - identify subtasks and assign to each member with deliverables and due dates.
  - GitHub is recommended to manage your project and coordinate the development (git is installed on rasa.cs.franklin.edu for your convenienc. Please invite your professor to access your repo.)

### Activitiy 3:
You should complete the following:
 - individual: Use this [template](COMP-670-Virtual-Human-Project-Weekly-Individual-Report-short) to create and submit a Weekly Status Report. 
 - team
   - create the bot web page and share with your users
   - regularly review and update conversation data in Rasa X
   - continuously develop/improve your own action server if needed
   - constantly train and test your bot
   - regularly back up your training data 
   - periodically purge models no longer needed to free up storage
   - Review the following:
	  - [Conversation-Driven Development](https://rasa.com/docs/rasa/conversation-driven-development)
	  - [Testing Your Assistant](https://rasa.com/docs/rasa/testing-your-assistant)
	  - [Setting up CI/CD](https://rasa.com/docs/rasa/setting-up-ci-cd)
 
### Activitiy 4:
Your team should complete the following:
  - identify at least one Virtual Human Agent by other teams
  - interact with the agent and evaluate its performance. It won't be surprising to anyone who's built an AI assistant that measuring success can be subjective. Success can mean a lot of different things:
    - Did the assistant correctly classify a message's intent and extract the right entities?
    - Was the right response selected?
    - Was the user's sentiment positive?
    - Did the assistant help the user achieve their goal?

Review [how to measure success](https://rasa.com/blog/using-conversation-tags-to-measure-carbon-bots-success-rate/).

### Activitiy 5:
Your team should complete the following:
- Submit a final report (details are coming soon)
- Submit a single zip file of `/public_html/index.html` and the entire bot directory and files EXCEPT `models`:
```
.
├── actions
│   ├── __init__.py
│   └── actions.py
├── config.yml
├── credentials.yml
├── data
│   ├── nlu.yml
│   └── stories.yml
├── domain.yml
├── endpoints.yml
├── models
│   └── <timestamp>.tar.gz
└── tests
   └── test_stories.yml
```
**Note: do not include the models directory**
