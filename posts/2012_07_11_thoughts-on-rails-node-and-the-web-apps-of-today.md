*11th July, 2012*
Thoughts on Rails, Node, and the web apps of today. 
===

Ruby on Rails is great. Having used it in web startups, on client projects at New Bamboo, and even in big old corporates like AOL, it has proven itself.

In 2010, if I was building a pet project, I would lean towards using Rails, or Sinatra if it was really small. But today, I now find myself using Node.js with either Express or SocketStream. 

I have abandoned Ruby and Rails in its entirety. Why?

The single page application
---

The Single Page Application comes to mind. It has changed the way we think of how apps should work. It's the current step along a journey that began with AJAX. 

Rails made it easy to build AJAX-powered web applications; We had our view templates on the server, compiled them there, and shipped them to the client. Any AJAX feature simply fetched the compiled html and sent it back to the browser for the client to handle. Why would anyone want to change that?

The Server is the API
---

When you use Rails the way Rails wants you to use Rails, it's really productive. 

But when you begin developing mobile applications that talk to the server via an API, you realise that the View in MVC does not always belong on the server. The presentation layer belongs to the domain of the client, and the server is the API. This decoupling of MVC is well-supported, but you then find that you're using Rails as an API alongside being a web application; It's not a clean definition of responsibilities.

And that's not all...
---

The view in MVC is not just HTML and CSS; it's the presentation logic, and the presentation logic needs structure. With this need, client-side frameworks like [Backbone](http://backbonejs.org/), [Spine](http://spinejs.com/), and [Ember](http://emberjs.com/) have come into the picture.

These frameworks have shifted the location of MVC between the client and the server. That is not to say that the server is just a dumb wrapper around the database, far from it. It is to say that the logic of the application is now split between what is required in the API, and what is required by the client.

We're now forced to __think about where our logic belongs__, and not just follow the train tracks laid out in front of us.

So your Rails server becomes an API, and your web site, like the iOS app, is the client. It's a clean separation of responsibilies, but given what Rails was designed to do, it's like having a horse rider climb on top of an elephant.

So you begin to ask, why should I use Rails instead of something like Sinatra or Goliath? what is the value of Rails as just an API?

Or to put it this way, why would you consider alternatives? 

Rails' Performance
---

When I think of Ruby and Rails' performance, I think of Ilya Grigorik.

On his [blog](http://igvita.com), Ilya wrote (and continues to write) a string of fantastic posts about improving the speed and performance of web applications, and he noted that [Rails was not the fastest tool out of the box](http://www.igvita.com/2010/06/07/rails-performance-needs-an-overhaul/).

In my opinion, he hit the nail on the head: (from the link above):

<blockquote>There is nothing about node that can't be reproduced in Ruby or Python (EventMachine and Twisted), but the fact that the framework forces you to think and use the right components in place (fully async & non-blocking) is exactly why it is currently grabbing the mindshare of the early adopters. Rubyists, Pythonistas, and others can ignore this trend at their own peril. Moving forward, end-to-end performance and scalability of any framework will only become more important.</blockquote>

Ilya mentioned the framework/ecosystem that I now consider to be the threat to Rails:

Node.js
---

When my boss asked me to take a look at Node.js at AOL around Christmas 2010, my view of Node at that time was one of indifference to it. I downloaded code, built a sample app, looked at the docs, the libraries, and got a feel for it. 

The biggest thing I noticed was the difference in performance. It consumed less memory than Ruby, and it served more requests per second than Sinatra or even Rack. What made it even more interesting was [CoffeeScript](http://coffeescript.org); you could write JavaScript with fewer characters and a nicer syntax. That made Node more accessible to Rubyists like me.

In the new year, we were asked to build an internal account management tool, and we asked if it we could build it in Node. My boss' boss gave the thumbs up. This was a chance to get a real feel for what Node.js could do.

Node turned out to work fantastically well in our case. As companies like [LinkedIn have proven](http://news.ycombinator.com/item?id=2891025), it can be used in the Enterprise, and perform well against high-traffic sites. Is it as enterprise-ready as Rails? I'd say that Rails is more mature and complete as a framework, especially when it comes to doing outside-in BDD.

The web apps of then and now
---

When Rails came about (all the way in 2004), it was built at a time when MySpace was the daddy and Twitter didn't even exist. It didn't say "oh let's try and do what PHP does because everyone uses PHP"; it was fresh thinking. That kind of departure from the status quo is good; it's how we evolve.

To Rails' credit, people have made various attempts to port it to Node.js, but in doing that, they are passing on an opportunity to rethink how web apps in today's world should be built. A lot of things have changed in the past 8 years, including Internet technology, and if I had to name one technology that comes to minds, it's WebSockets.

The rise of the real-time web
---

Following a session on WebSockets presented by Peter Lubbers at Skills Matter, New Bamboo embarked on some WebSockets hacking at a company hack day. That hackday project then ended becoming [Pusher](http://pusher.com), and that is the best reason I can give for why all companies should have hack days.

At the time it looked fun, but I never imagined it would end up being a big deal. I made some fun demos, one of which was brilliant. I had made a HTML5 keyboard called [Sweet Music](http://sweetmusicapp.com), and I would play it at 10am every day for the daily standup. Then one day I hooked up Pusher to it, so that I could remotely trigger the "waaa" from any web browser. Before I left New Bamboo to join AOL, I had left a web browser with Sweet Music open on one of the monitors in the office, and turned off the screen so that no one would notice. Come the following Monday when I was no longer there, I opened up my laptop, and pranked the bambinos with Sweet Music, right on time.

Any interest in WebSockets was left at New Bamboo, as I dived into building a big HRM tool for AOL. It was a fun couple of months, as I discovered what working for a big company was like. At the end of the year, my boss decided to do some research into various web technologies.

He went to Peter Lubbers' WebSockets session at Skills Matter.

He came back very excited about 'dem sockets. During the time we spent building the account management tool in Node.js and MongoDB, Owen went much further, and started putting together a web framework that used WebSockets to transmit data between the client and the server. That web framework is [SocketStream](http://socketstream.com).

Peter Lubbers was key to both Pusher and SocketStream, and I was very fortunate to witness the beginning of both of those things. They are a part of what is now termed "the real-time web", and it's a growing business; companies like [Meteor](http://meteor.com/) and [Bridge](https://getbridge.com/) are proof to that.

The real-time web is an opportunity to rethink how applications should work (like my app [Dashku](https://dashku.com)), as well as how we as developers build them.

For example, improving developer workflow. One of the nice features of SocketStream is that when you edit a CSS file in development mode, the changes get pushed up to the browser straight away, so rather than having to reload the page to see your changes, you see them instantly. If you modify a client-side Javascript file, the page reloads for you to checkout the change. It's a quicker way of doing things.

The real-time web is exciting.

Conclusion
---

When you look at Twitter, or LinkedIn, or Yammer, they all used Rails at the start. But over time, they started replacing various pieces with Java, or Node in LinkedIn's case.

When I consider the combination of Single Page Apps, relegating back-ends to being APIs, the growing importance of performance & scalability, the momentum behind Node.js, and the rise of the real-time web, I see a picture emerge where the back-end will become purely an API component, and one that is swapped out for more performant alternatives over time. 

How does Rails fits into that picture? I'm not sure.

