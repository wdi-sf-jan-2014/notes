

## The Internet and Networking

Lot's of what we did over the last couple of days was low level stuff: binary search, write your own sorting algorithm, the inner workings on blocks - pretty advanced topics for only a week into the class, be proud of yourselves :-). I think Sarah hit the nail on the head when she said: *First you learn it the hard way, then you learn how to set it up/use it/configure it in rails or other frameworks.*

So far we have written what's called *stand alone applications*. You run them on a computer, they do stuff, then terminate. Like Rental App manager, or MS Word. Now enter the internet, more specifically the world wide web.

Let's start with the history of the Internet - from the early beginnings to 1990. There's been written a lot about the early days of the Internet and there are a number of good documentaries. I found this 8 min clip very instructive and fun:

- https://www.youtube.com/watch?v=9hIQjrMHTv4

OK, the internet is a worldwide network of connected computers. Machines can connect to each other and exchange information.

Let's look at the main components of a computer network

**Server**

  * machine on the internet in an 'always on' state
  * represent a 'service' of some type (like facebook or google search)
  * some servers just route traffic
  * server (software): process responsible for handling requests
  * server (hardware): machine which runs server software
    
**Application**

A useful system of services (databases, email, web), we are mainly concerned with web applications on the **World Wide Web**

**Client**

A program that you use to run applications and access services, usually a web browser.

	
##World Wide Web

The World Wide Web is a collection of documents, made up of HTML, that lives on servers of the Internet. In this lesson, I'm not going to talk about the structure of HTML pages: syntax / forms / css / meta data. That's a different lesson for another day.

HTML is the basis for almost every web page, it can contain text, images, video - html is what glues everything together - links between the pages makes the web *web-like*. 

The World Wide Web emerged in the early nineties. The first web page was build at CERN (European Organization for Nuclear Research) by Time Berners Lee, he is credited with the invention of the web - he implemented the first successful communication between a Hypertext Transfer Protocol (HTTP) client and server via the Internet. Why am I telling you this? Because he build the World Wide Web on a Next computer - and I'm a big Next fan. So here's a pic of the first web server (note the sticker on the box):

	http://en.wikipedia.org/wiki/File:First_Web_Server.jpg 

And here is the first ever web page:

	http://info.cern.ch/hypertext/WWW/TheProject.html**

Now let's talk about the major pieces of the web:

**URLs**

A URL is a path to a specific server and a certain document on that server. We are all familiar with URLs.

The main parts of an URL are:

- protocol  (http means the web .. there are others like ftp)
- host (name of the server, translated to an IP address)
- path (document that that is being requested)
- query params (aka GET parameters) - extra info that the server gets. 

Example:

http://www.chase.com/account/history?num=112122&page=3
PROTOCOL HOST      PATH            QUERY PARAMETERS

Another piece of the URL is the port. A port is a specific door in the server. By default, the web port is 80 - other ports are used for other services: email, file transfer, more … The port number is tagged on to the server name, separated with ':', for example *www.example.com:8080*

##What are protocols?

We already mentioned protocols. A computer communication protocol is a description of the rules computers must follow to communicate with each other. The main protocol on the Internet is TCP/IP

**TCP/IP**

TCP/IP is the communication protocol for communication between computers on the Internet.  

It stands for *Transmission Control Protocol / Internet Protocol*.  

TCP/IP defines how computers should be connected to the Internet, and how data should be transmitted between them. Web browsers, for example, use TCP/IP to communicate with Web servers. TCP takes care of:

- Packet Switching
- Guaranteed Delivery
- Routing

Each server on the internet has an IP address that uniquely identifies the server in the network.

Find out your ip address (Mac only):

	ipconfig getifaddr en1

TCP/IP is the basis of all internet communication: web, phone, email, video conferencing, movie streaming - one the lowest level, everything is handled by TCP/IP.  

#### TCP/IP activity: traceroute & netcat

**traceroute**

Follow the path of a client/server request through the Internet:

- traceroute www.whitehouse.gov 
- traceroute www.taz.de

**netcat -> chat server out of the box**

*man netcat* to see what it does. Let's connect two computers and exchange packets! 

Get into pairs, one person is A (the Server), the other person is B (the Client)

Person A: find out your IP address and share it with Person B. 
Now:

Person A (Server), in your shell, create server that listens for data:
>  nc -l 3333 <enter> 

Person B (Client), in your shell, create a client connecting to the server:
> nc <server ip address> 3333 <enter>

Now start typing … packets of information are exchanged between client and server using the tcp protocol.


## Hypertext Transfer Protocol

HTTP is a layer above TCP. 

It specifically handles the exchange of documents -> HTML documents / web pages.

**HTTP REQUEST AND HTTP RESPONSE**

So by typing in a url and hitting GO in your browser, what happens …

In order to get a document, a browser needs to send a request to a server - that's an HTTP request. The request is routed through the internet to the server handling the request. The server executes a program and responds with an HTTP response, usually the web page that was requested.

There are different types of HTTP Requests - they are expressed as verbs - quick overview: We get into more detail when we talk about APIs and how to consume services on the Internet.

* `GET` - request a document/resource, the most common request type
* `POST` - create a resource on the server, for example creating a facebook update
* `PUT` OR `PATCH` - update a resource, for example updating your bank account
* `DELETE` - destroy a resource, for example deleting a todo list item

more info: http://www.tutorialspoint.com/http/http_methods.htm

HTTP request have status codes, You may know:

- 404 - page not found
- 500 - internal server error
- 200 - OK, all is good

Here's a list of all status codes: http://en.wikipedia.org/wiki/List_of_HTTP_status_codes

**HTTP requests/responses have a header and a body**

Headers are made up of key/value pairs and conatin meta data about the request/response. Example:

REQUEST HEADER FORMAT:

	Host: www.google.com
	User-Agent: chrome
	There's more ...


RESPONSE HEADER FORMAT: 

	Status: -> HTTP/1.1 200 OK 
	Headers - like request
	Date: 
	Server: apache
	Content-type: type of document being returned, so browser knows what to do
	Content-length: how long is the document (not required?

**The BODY of the response contains the actual document, usually that's HTML**

So the purpose of a web server is to respond to HTTP requests. And we are going to learn how to write applications running on web servers that respond to HTTP requests … web applications!


#### HTTP activity: 

**telnet**

In your shell:

	telnet www.google.com 80
	GET / HTTP/1.1

Talk http to google. Request google.com home page, see what you get back. Inspect the HTTP Response header on top.

**Chrome console**

The console is going to be your friend.

Load any web site in your browser and open the console: View -> Developer -> JavaScript Console

Let's look at some tabs:

- Elements: this is the html document and css styles that make up the page

- Network: Examine http requests that the browser sends to the server. 

- Console - a place to talk Javascript to the page, that's for later


