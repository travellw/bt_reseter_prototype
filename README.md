# Reseter

The Reseter is a lightweight internal tool used to refund transactions in bulk via Braintree's Application Programming Interface (API). Oftentimes merchants, typically in the small to medium size business space, who have experienced carding attacks do not have technical resources available to execute this on their end. As a result large fees, decreased customer loyalty, and disordered operations cause merchants to lose revenue or leave Braintree altogether. The PayPal teams (outside of the Braintree API Support team) that service them do not have the resources (time, insight, tooling) available to directly assist merchants who have experienced carding attacks. Ideally, the Reseter eliminates that barrier for those teams leading to a better merchant experience.

![](https://github.com/travellw/bt_reseter_prototype/blob/main/public/images/Screen%20Shot%202021-10-20%20at%209.24.18%20AM.png?raw=true)

## Architecture

#### Technical Stack

* [Sinatra](http://sinatrarb.com/) 
* [Bulma CSS](https://bulma.io/) 
* [Braintree API](https://developer.paypal.com/braintree/docs/start/overview) 
  * Ruby SDK - Server-Side

#### Languages

* Ruby
* HTML
* Javascript
* CSS

## How it Works
* Instructions for Loading a CSV
* Flow Diagram

## Set Up Steps


## API Reference Documentation
* [Braintree's Set Up Your Server for Ruby SDK](https://developers.braintreepayments.com/start/hello-server/ruby)
* [Transaction Refund API Call](https://developer.paypal.com/braintree/docs/reference/request/transaction/refund)
* [Ruby CSV Gem](https://github.com/ruby/csv)

## Knowledge Documentation
* [Refunder Confluence Page](https://engineering.paypalcorp.com/confluence/display/SUP/Refunder)
* [Refunder Github repo](https://github.braintreeps.com/braintree/api-support/tree/master/tools/refunder) 


## Versioning

We use [Semantic Versioning](https://semver.org/) for versioning major changes to this project. See below for versioning.
 
1.0.0 MVP  
