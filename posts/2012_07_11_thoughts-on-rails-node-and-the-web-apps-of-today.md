*11th July, 2012*
Thoughts on Rails, Node, and the web apps of today. 
===

Ruby on Rails is great. Having used it in web startups, on client projects at New Bamboo, and even in big old corporates like AOL, it has proven itself.

In 2010, if I was building a pet project, I would lean towards using Rails, or Sinatra if it was really small. But today, I now find myself leaning towards using Node.js with either express or SocketStream. 

I have abandoned Ruby and Rails in its entirety. Why?

The single page application
---

In my opinion, AJAX began the journey. Eliminating page reloads was nice, and Rails facilitated it; shipping Rails apps with the Prototype library by default, providing RJS to produce dynamic JavaScript code, and providing the respond_to block method to make it really easy to support AJAX request alongside the plain old HTTP request.

Of course, we had our view templates on the server-side, compiled them server-side, and shipped them to the client that way. Why would anyone want to change that?

The Server is the API
---

MVC is a nice pattern, and Rails was nice, and the de facto behaviour was to do things in the way of the opionated framework, because it was productive.

But once you had the advent of mobile apps, and the need to serve them alongside the web app as well as the API, you began to realise that the View in MVC did not always belong on the server. With iOS/Android applications, the View was handled by the mobile application, not the Rails application.

Then, when you began to compare the approaches of the web app to the mobile app, you begin to see that Rails' AJAX requests shipped redundant bytes, in the form of the html template. The HTML stayed mostly the same, only the data changed.

What if you treated the web application like you treated the mobile application, and delegated the view rendering to the client? 

The view, the presentation layer, belongs to the domain of the client, and the server is the API.

But that's not all...
---

The view is not just HTML templates; it's the presentation logic, and the presentation logic needs structure. With this need, client-side frameworks like [Backbone](http://backbonejs.org/), [Spine](http://spinejs.com/), and [Ember](http://emberjs.com/) have come into the picture.

These frameworks have shifted the location of MVC between the client and the server. That is not to say that the server is just a dumb wrapper around the database, but that the logic for how an application works does not necessarily belong on the server.  

When I was building Rails apps at AOL, I loved using Jose Valim's Inherited Resources gem, and using Cucumber and RSpec to do outside-in BDD. I bashed out code, and only stopped to think about the design of the REST API. It was wonderful. 

But it was also lazy.

With client-side frameworks, we're now forced to __think about where our logic belongs__. It's refreshing, and it made me think. If the server is just the API, then what stops you from using other frameworks, like Sinatra or Goliath? what is the value of Rails as just an API?

Or to put it this way, why would you consider alternatives? 

Rails' Performance
---

When I think of Ruby and Rails' performance, I think of Ilya Grigorik.

On his [blog](http://igvita.com), Ilya wrote (and continues to write) a string of fantastic posts about improving the speed and performance of web applications, and he noticed that [Rails was not the fastest tool out of the box](http://www.igvita.com/2010/06/07/rails-performance-needs-an-overhaul/).

In my opinion, he hit the nail on the head: (from the link above):

<blockquote>There is nothing about node that can't be reproduced in Ruby or Python (EventMachine and Twisted), but the fact that the framework forces you to think and use the right components in place (fully async & non-blocking) is exactly why it is currently grabbing the mindshare of the early adopters. Rubyists, Pythonistas, and others can ignore this trend at their own peril. Moving forward, end-to-end performance and scalability of any framework will only become more important.</blockquote>

Ilya mentioned the framework/ecosystem that I now consider to be the threat to Rails:

Node.js
---

When my boss asked me to take a look at Node.js at AOL around Christmas 2010, my view of Node at that time was one of indifference to it. I downloaded code, built a sample app, looked at the docs, the libraries, and got a feel for it. 

The biggest thing I noticed was the difference in performance. It consumed less memory than Ruby, and it served more requests per second than Sinatra or even Rack. Then what then made it even more interesting was [CoffeeScript](http://coffeescript.org); you could write JavaScript with fewer characters and a nicer syntax. It made it that more accessible to Rubyists like me.

In the new year, we were asked to build an internal account management tool, and we asked if it was ok to try and build it in Node. My boss' boss gave the thumbs up. This was a chance to get a real feel for what Node.js could do.

Node turned out to be a wonderful little tool. It's amazing to be able to write both client and server-side code in the same language, and as companies like [LinkedIn have proven](http://news.ycombinator.com/item?id=2891025), it performs very well. When I compare Rails to Node, I consider Rails to be more mature and complete, but I find Node.js to be far more enjoyable and performant.

Another thing is that Rails was built at a time when PHP was king, and the web applications of that time compared to the web applications of now are ancient. Rails is good, and to its credit people have tried to port it to Node.js, but that is passing up on an opportunity to rethink how web applications of today should be built, using the technology that exists today.

If one technology comes to minds, it's WebSockets.

The rise of real-time
---

When I first saw WebSockets in action at a New Bamboo hack day, I never imagined it would end up being a big deal. Sure, I'd built a demo or two using it, and then New Bamboo took their hack day project and turned it into [Pusher](http://pusher.com), and I left New Bamboo to join AOL. 

Then my boss went to Peter Lubbers' WebSockets session at Skills Matter, and he took a big interest in it. He appreciated the benefits of WebSockets over the standard HTTP request. With it, he eventually built what is now known as [SocketStream](http://socketstream.com).

The real-time web is an exciting prospect, and it's not just about chat applications. If you go to Pusher's site, you'll see games, analytics services, and collaboration tools. It's not just about receiving data in real-time; in combination with client-side MVC frameworks, the need to fetch data from the server upon loading a given resource is reduced; you can fetch the start at the start of loading the application, and then have any changes to that data be broadcast from the server to all the clients. The need to reload data from the server is gone. 

There are so many possibilites, and not just for how applications work, but how they are built too. One of the nice features of SocketStream is that when you edit a CSS file in development mode, the changes get pushed up to the browser straight away, so rather than having to reload the page to see your changes, you see them instantly. This is improving developer workflow.

Back on point
---

When I left AOL and joined a startup, the tech stack there was Rails, MongoDB, and Heroku. Going back to Rails after using Node.js was terrible; I didn't enjoy working with it anymore. The application was slow to load on my MacBook Air, and eventually I did a factory reset on the laptop to see if I could make it perform any better. The performance improved, but it was nothing compared to working with Node. Subsequently, I was let go by the startup, and I went on and built [Dashku](https://dashku.com), which I thoroughly enjoyed building.

I might be wrong, but I think that once you use Node.js and build real-time apps, it's difficult to enjoy doing anything else. 

Has anyone else had a similar experience? Let me know.