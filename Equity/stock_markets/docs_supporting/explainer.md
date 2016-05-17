---
title: "Stock Markets"
author: "Matt Brigida"
date: "July 3, 2015"
output: html_document
---

Stock markets allow for the exchange of ownership in publicly traded corporations. Someone with excess cash can invest in a company (become a partial owner) as a way of saving for the future.  A retiree can sell stock to generate cash.

The stock market which you see every day on the news is the "secondary" market.  This means it is comprised of entities (people, corporations, investment funds, etc) exchanging stock among themselves.  The actual corporation is not involved. So if you sell IBM stock to a mutual fund, this is a secondary market transaction.  Note in secondary market transactions, no stock is created or removed from the market.

The "primary" market refers to transactions in which the company itself is involved.  Examples are the company's initial public offering (IPO) and later stock sales and purchases conducted by the company.  It is in the primary market that companies raise money to operate their business.

Given that the company is not involved in secondary market transactions, is the secondary market important to the company?  Yes!  The company would obviously like to sell stock in the primary market for the highest price possible.

Consider if there is a very poorly functioning secondary market such that you can only buy or sell stock every year.  Would you be willing to pay a high price for the stock in the primary market?  What if, for an unseen reason, you needed cash in the middle of the year? Alternatively, what if a stock had a very liquid secondary market such that you could sell the stock any day.  Surely you would be willing to pay more for the stock.

In short, a well-functioning secondary market ensures companies are able to raise as much cash as possible in the primary market.  More cash allows the companies invest in more assets and research, and raises economic growth.

## Stock Markets: Past and Future

A stock market is comprised of market makers (also known as dealers), brokers, and investors.  Market makers stand ready at an moment to buy or sell stock.  They do this by always posting bid and ask prices.  The bid in the price at which they are willing to buy, and the ask is the price at which they are willing to sell.  Brokers transact with the market maker on behalf of investors.  Often institutions will act as both market makers and brokers (this is the title broker/dealer which you have probably heard). 

In the past the stock market was the physical location where the market makers stood.  If you wanted to buy or sell stock, you went to this location and transacted (or directed your broker to do so).  This original location in the US was famously under a buttonwood tree outside of 68 Wall Street in New York City.  This meeting arrangement eventually became the New York Stock Exchange.

The stock market has since evolved into a purely electronic interconnection of market makers spread out among about 18 exchanges across the US.  When you enter an order to buy stock it is routed to one of the market makers at one of these exchanges.

US stock markets are regulated by the US Securities and Exchange Commission (SEC).  In 1976 the SEC implemented the Consolidated Tape System, which records the best bid and ask prices across all exchanges at any given point in time. This attempts to give a comprehensive view of trading occurring across these many exchanges.

In 2005 the SEC released Regulation National Market System (Reg. NMS) which further tried to ensure that investors received the best bid and ask price available across the many markets.  It also tried to make sure investors have access to market quotes at reasonable fees.  The best bid and ask (or offer) is known as the NBBO -- the National Best Bid and Offer.

### So what is an exchange today?

Each individual exchange is a system of computer servers which run an order matching engine.  An order matching engine received orders and then handles them according to a series of rules. One rule is that it must fill an order at a price not worse than the NBBO.  There are many other rules.  Some rules are employed at every exchange, and some which are specific to a particular exchange.

For example, lets say you send an order to buy a stock at no higher than \$100 (limit buy @ 100), but the offer is presently \$98, then your order is transformed into a market buy order and you pay \$98. The matching engine also executes orders contingent on arrival time.  A good description of an order matching engine is provided by the [Chicago Stock Exchange](http://www.chx.com/trading-information/matching-system/).

## Stock Exchanges and the Flow of Information

Stock markets incorporate the flow of information into prices.  The term in financial economics for the speed an accuracy with which information is incorporated into prices is 'market efficiency'.  At present stock markets react to information at the speed of light.

Interestingly, however, since the computer server for the 18 exchanges are located at geographically distinct points, the prices are slightly different at each exchange.  This is not a difference a human can notice -- but a computer can.

Not only are prices slightly different due to the distance between exchanges, but each exchange is a set distance from points where information is generated.  Market moving information is often generated in Washington D.C. and Manhattan, NYC.  Exchanges closer to these points will incorporate the information sooner. 

A great example of this is how markets react to announcement from the Federal Reserve in Washington D.C.  New York markets are closer than Chicago markets (by a few milliseconds at the speed of light).  So with sufficiently finely grained price data (like that provided by [Nanex](http://www.nanex.net)) you can see New York markets move prior to Chicago's.  In fact, this is how it was noticed that information was leaking prior to the Fed's announcement -- a trader in Chicago reacted faster than the speed of light, and so it was clear the trader obtained the information prior to the announcement.  

### Dark Pools

Recently organizations have set up exchanges, called dark pools, which don't share information with public stock exchanges. There are about 40 operating today.  The reasoning for the dark pools, is that you can trade large blocks of stock without signaling your intentions other market participants.  When trading in a dark pool you should still receive a price no worse than the NBBO, though this is hard to monitor given dark pools do not supply trade and quote data to the consolidated tape.  

