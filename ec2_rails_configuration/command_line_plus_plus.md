# Command Line++

__OBJECTIVE__: Get stronger with command line tools.  Here are some of the tools you will be using:

* screen
* fg
* bg
* CTRL+z
* vim
* grep
* top
* ps
* kill
* head
* tail
* chmod

## Documentation

The man pages are the best place for documentation for all of these programs.  For example, ```man grep``` on your terminal will give you more information on the tool.

## Overview

Here is an overview of all the tools listed.

__screen__ Keeps a terminal session running even after you exit the terminal

__fg__ Bring a process from the background to the foreground

__bg__ Bring a process from the foreground to the background

__CTRL+z__ Stop a running process

__vim__ A command line file editor.  You will need to get comfortable with it when working in an ssh session.

__grep__ Searches through files and finds matches.  Can also use regular expressions to do matches.

__top__ Displays real time system information, e.g., CPU%, Memory usage, etc.

__ps__ Lists running processes

__kill__ Kills processes

__head__ Output the top of a file to the terminal

__tail__ Output the end of a file to the terminal

__chmod__ Change file permissions

## Exercises

1. Run any rails application with the following command:  ```rails s &```.  What does the '&' do?  What does ```fg``` do?
2. Run any rails application with the following command: ```rails s```.  What does ```CTRL+z``` do?  What does ```bg``` do?
3. With the rails server running in a different terminal window, run ```tail -f log/development.log```.  Interact with your rails webpage, so that some requests are made to the server.  What is tail doing?
4. From the terminal, run the command: ```screen```.  Run ```rails s```.  Figure out how to detach from the screen window without killing the rails server.  Once detached, reattach to the screen.
5. Go to the command line and run: ```vimtutor```.  Complete lessons 1 and 2.  Feel free to do more lessons if you'd like.
6. Clone the [command line mystery repo](https://github.com/veltman/clmystery).  Read the instructions and the cheatsheet.  __DO NOT USE ANY GUI APPLICATIONS.  NO SUBLIME TEXT, NO FINDER.  ONLY TERMINAL!!__ The cheatsheet is an exception.  You can use a pdf viewer to read that if you like.
7. In the daemon directory,  run the following command ```ls -l; chmod +x controller.rb```.  Run ```ls -l``` again. What has changed about ```controller.rb``` in the ls output.  What does ```chmod +x``` do?
8. Next, in the daemon directory, run ```./controller.rb start```.  Do you notice any slowness with your computer?  Try running ```top```.  What does it tell you?
9. Next, run ```ps aux```.  What does it tell you?  Pipe the output to grep using ```ps aux | grep <some search string>```.  What did grep find?
10. Kill the problematic process.

# Resources
* manual pages: ```man greg```
* [Description of linux permissions](http://linuxcommand.org/lts0070.php)
* [Command line mystery repo](https://github.com/veltman/clmystery)






