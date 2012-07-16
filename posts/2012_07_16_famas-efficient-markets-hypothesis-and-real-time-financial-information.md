*16th July, 2012*
Fama's Efficient Market Hypothesis, and real-time financial information
===

Someone [recently ported Transport Tycoon Deluxe to the browser via Emscripten](http://play-ttd.com/). As a child, I have fond memories of that game, one of which was of the income statement. If you had enough vehicles, trains, aircraft & ships in operation, the numbers on the income statement would change multiple times a second.

In the real world, income statements take much longer to be calculated and presented. The Wall Street analysts then have the task of estimating what the results will be, and when the results are announced, the share price of the firms travels north or south, depending on whether the results exceeded or missed expectations. The gap between results and expectations allows for the kind of frenzied activity that attracts volatile share price movements.

One crazy day
---

I recall the day that AOL announced its Q2 2011 results. Before then, I had built a Stock Ticker using a spare computer; it screen-scraped the share price from Google Finance, and printed it out to the command-line in big characters using the node.js npm module [Asciimo](https://new.npmjs.org/package/asciimo).

<img src="/images/stock_ticker.jpg" width="480px" alt="Stock Ticker" />

That day, AOL had announced results which missed expectations. The opening price was just above $15, but within the first 10 seconds of trading activity, the share price dropped by almost 9% (as shown in the image above). The drop didn't stop there, and it became headlines. By the end of the day, AOL's share price finished somewhere around $10.17; almost a third of the share price had been wiped out in the space of a day. It was crazy.

The steep decline raised questions. How does a firm lose a third of its value in just one day? It brought me back to something I had learned about at University... Fama's [Efficient Market Hypothesis](http://en.wikipedia.org/wiki/Efficient-market_hypothesis). 

Fama's Efficient Market Hypothesis
---

Fama's EMH asserts that when it comes to the pricing of assets, financial markets are 'informationally efficient'. For example, the moment a company issues a profits warning to the market, the market immediately factors that piece of information into the share price of the company.

That's a very basic explanation. Fama's EMH suggest 3 forms of market efficiency; weak, semi-strong, and strong.

* Weak form means that the asset's price has factored in all public information relating to that asset, but nothing more.
* Semi-strong form means that on top of factoring in past information, the asset's price will change instantly the moment new public information becomes available (like the example above).
* Strong form means that the asset's price also factors in non-public information (i.e. Insider knowledge).

In the context of what happened that day, you could argue that the market was semi-strong; the earnings were announced, they missed expectations, and the share price bombed pretty quickly. But was it rational that a company's price had lost a third of it's value in one day?

Behavioural Finance
---

Fama's EMH has it's criticisms, such as it's dependence upon all investors acting rationally. Much as we try, we humans are not walking, talking calculators. Psychologists have conducted research which shows that investors exercise cognitive biases, such as overconfidence and overreaction. We also exhibit a sheep mentality, piling onto heavy trading of assets to snowball the run on them. One example is that of the short-selling of HBOS' stock in 2008. 

On the 17th September 2008, the bank's share price swung wildly between 220p and 88p per share. Short-sellers were betting that HBOS were in trouble, and it became so problematic that the FSA banned the short-selling of shares of HBOS alongside 31 other financial firms. Was the pricing of HBOS' shares efficient, or was it being hampered by a herd mentality that saw an opportunity to make the market? The FSA investigated whether short-sellers had colluded to force the price down, but found no proof.

Although that example occurred at a time of great financial trouble, the next example happened at a less rockier period, and was created by robots.

The flash crash
---

On the 6th of May 2010, the Dow Jones Industrial Average, down 300 points on the day, dropped by 600 points within 5 minutes. 20 minutes later, it then recovered most of the 600 point drop. ['The flash crash'](http://en.wikipedia.org/wiki/2010_Flash_Crash) resulted in a 5-month investigation by the SEC and CFTC to figure out what had happened. Their findings concluded that a large mutual fund's selling of $4.1bn worth of 75,000 E-Mini S&P 500 contracts caused High Frequency Trading Algorithms and other traders to close their positions and sell aggressively, snowballing into a run on various stocks and assets.

__In our quest to make money, we have made computers behave irrationally. If there was such a thing as Artificial Stupidity, the HFT creators deserve a Nobel prize for their efforts.__

Of course, the events of May 6th 2010 have not stopped the High Frequency Trading algorithms from being utilised on the markets. If anything, the whole field of computerised trading is becoming the arms race of the 21st Century.

Humans with Robots vs Humans with Robots
---

High Frequency Trading is a field of Finance where a combination of powerful computers, ultra-low latency networking, and mischevious algorithms come together to make money in the tiniest fractions of a second. Fama's EMH is being tested by the race to obtain and process information faster than anyone else. Financial firms are taking incredible steps to achieve this; not only are they modifying operating systems at the lowest levels of coding (including the Kernel), but they are also [spending $300m to lay down a new fiber-optic line across the atlantic, just to shave 5.9ms off the time data takes to travel between London and New York](http://www.businessweek.com/articles/2012-03-29/trading-at-the-speed-of-light).

However impressive those things are, the most interesting thing to me is what the High Frequency Trading algorithms are being trained to do.

On a simple level, High Frequency trading algorithms are geared to exploit the tiniest of price inefficiencies that occur between related assets. They get the processed information as fast as possible, and push their trades to the market as quickly as possible.

On an espionage level, HFT algorithms are being trained to spot firms trying to discreetly buy up shares in a stock for an acquisition target for a client. Some engineers have compared this to the task of "spotting a submarine's sound signal in a sea full of whales". The algorithms spot this activity, and buy shares to gain on the price increase.

On a more insane, but fascinating level, another type of algorithm is emerging, known as "Spoofers". Spoofers buy shares to mimick the pattern of discreetly acquiring shares in a company for a client. They intend to lure other HFT algorithms into spotting that behaviour, and get them to buy up shares in the target firm. What those HFT algorithms don't know however, is that there is no M&A client, and that the Spoofer is going to short the stock, thus gaining at the expense of those HFT algorithms.

__We are training robots, to be pretend to be humans, to lure other robots, only to then screw those robots (and their human owners) over.__

And we are doing this all in the name of Finance. Incredible.

But if this is how the markets work...
---

Then are they the right place to trade shares in a company, given what the markets are now doing?

This is a difficult problem. The scandals that have occurred over the last couple of years, and recently with Libor, suggest that greed is doing more corruption than good. I would argue that contrary to statements of the benefits of accountability and transparency, financial firms crave opaqueness and inefficiency. 

If the information about how Goldman Sachs were shorting shares of assets that they were also selling to clients was public, would that scandal have occurred in the first place? The clients would be able to question Goldman's inconsistent investment strategies. And coming back to the events of that day in August. 

If AOL's financial position had been reported with more frequency than once every 3 months, would the price have dropped as quickly, or closed at $10.17 on that day? Maybe the market would have reacted with less volatility, and the markets would not be prone to the cognitive biases that we exhibit. The markets would be more rational, and thus more efficient.

What if financial reports happened in real-time?
---

This lead me to a crazy thought. Why aren't public companies reporting their financial positions more frequently, even as quickly as they did in Transport Tycoon Delxue? No more surprises. No insider knowledge. Greater transparency.

Ironic to think that as a simulation of the world of business, Transport Tycoon Deluxe has something to offer us back in return. 