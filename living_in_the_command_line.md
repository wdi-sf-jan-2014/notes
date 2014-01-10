# Living in the Command Line
Web programmers have to live on the command line.  It gives us fast, reliable, and automatable control over computers.  Web servers usually don't have graphical interfaces, so we need to interact with them through command line and programmatic interfaces.  Once you become comfortable using the command line, staying on the keyboard will also help you keep an uninterrupted flow of work going without the disruption of shifting to the mouse.

## Notes before we start
For any command we discuss here, the command `man`, short for __manual__, will give a (hopefully) detailed explanation of that command.  Sometimes that explanation will be too detailed for you.  When you get lost in a man page and you want to understand it, start again from the beginning of of the __man page__ and keep repeating.  Hopefully you will get further into the page each time you read it.

## Metaphors
The command line is my home.  I literally think of using the command line as walking around a building.

#### Where am I?
`/` is the entrance - the __root directory__ - but I usually start out in `/Users/raphael`, which is my room, my __home directory__.  My home directory can also be called `~`. 

The room I'm currently in is called the __working directory__.  When I open a new terminal, my home directory is the working directory.  Wherever we are, `pwd`, short for __print working directory__, will show us what directory we are in.
   
#### Look around:
I look around the room I'm in  - the working directory - with `ls`.  `ls` stands for list directory contents. Try typing `open .` to open the current directory in Finder, then type `ls`.  You should see something like the result below:

    Applications      Library           Pictures          downloads.txt     output.pdf        workspace
    Desktop           Movies            Public            dump.rdb          sizereport

  
I can see everything, including hidden files and folders, with `ls -a` for List All:  

  - In every room (folder) you'll see `.`, which I think of as being the floor.
  - You'll also see `..`, the door you came in through, which is the folder above the current folder.
  - Any other files which begin with `.` are considered hidden files.
		
		.                                                   .netrc
		..                                                  .pip
		.ghc                                                Applications
		.gitconfig                                          Desktop
		.gnupg                                              Documents
		.gnuplot_history                                    Downloads


I can look at everything in a more detailed list with `ls -l`.  List in a long format.  I've put in a header line so you can see what some of the columns are.  

		Permissions     Owner    Group    Size   Last Modified Filename
		drwxr-xr-x   45 raphael  staff      1530 Nov 21 23:30  Applications
		drwx------+  11 raphael  staff       374 Dec  4 09:09  Desktop
		-rw-r--r--    1 raphael  staff      8872 Nov 13  2012  downloads.txt
		-rw-r--r--    1 raphael  staff    191858 Nov 16 14:45  dump.rdb
		lrwxr-xr-x    1 root     staff         4 May 10  2011  usr -> /usr

Here's a tutorial on file permissions, if you're interested in unpacking that column: [http://en.flossmanuals.net/command-line/permissions/](http://en.flossmanuals.net/command-line/permissions/)

These can be combined into `ls -la`. List all in a long format.

Some of the entries I see are other rooms, which we call directories or folders.  List the contents of another room with `ls [dirname]`.  Try `ls Downloads`.  We can go further down into the house, into a sub-directory.

#### Move around:
I can change the room I'm in with `cd`.  `cd` stands for change directory.

We can move back to the root directory: `cd /`.  A path which starts from the entrance, the root directory, is called an __absolute path__.  Now look around.  What do you see?

We can move back home: `cd ~`.  What do you see?

I can move into my workspace directory: `cd workspace`.  A path which is relative to the current directory is called a __relative path__.

Hitting `<TAB>` autocompletes.  Hit `<TAB>` constantly.

It's important to remember that being in one room is much like being in another room.  The difference is in the contents and the relative position of other folders.

#### Build new rooms (making directories with mkdir)

Now that we know how to move around, it's time to make some changes. We can make directories with the `mkdir` command.  Look at `man mkdir`.  What's the format of the command for making a directory?

		MKDIR(1)                  BSD General Commands Manual                 MKDIR(1)
		
		NAME
		     mkdir -- make directories
		
		SYNOPSIS
		     mkdir [-pv] [-m mode] directory_name ...
		
		DESCRIPTION
		     The mkdir utility creates the directories named as operands, in the order specified, using
		     mode rwxrwxrwx (0777) as modified by the current umask(2).

Operands are what comes after a command, so we write `mkdir living_room` to make a new room, where we will keep our couches.  Keep your directory names lowercase in almost every case.  Separating words with underscores is called snake_case.

#### Furnishing the Room (editing files)

Let's `cd` into our new `living_room`  Look around with `ls`, and `ls -a`.  What do you see?


I want my living room to have a bookshelf full of books.  Let's make a file that lists all of our books.  Type `subl books` to open Sublime Text editing a new file called `books`.  Add a few books, copy and paste the section below so we all have some books in common, and save the file.  Make sure the books you add are in the same format:  `<author_given_name>, <author_last_name>:<title>`.

```
Carroll, Lewis:Through the Looking-Glass
Shakespeare, William:Hamlet
Bartlett, John:Familiar Quotations
Mill, John Stuart:On Nature
London, Jack:John Barleycorn
Bunyan, John:Pilgrim's Progress, The
Defoe, Daniel:Robinson Crusoe
Mill, John Stuart:System of Logic, A
Milton, John:Paradise Lost
Johnson, Samuel:Lives of the Poets
Shakespeare, William:Julius Caesar
Mill, John Stuart:On Liberty
Bunyan, John:Saved by Grace
```

Now try `ls` again.  Do you see the `books` file?  Look at the contents with `cat`.  Let's make another, smaller file, which will be our bookshelf.  Describe the bookshelf, and just say the description to ourselves.

	echo "The particle board of this bookshelf flexes under the weight of the books it holds, but it serves its purpose and does it cheaply."
	
`echo` is a command that just echoes (outputs) what we give to it as arguments (same as operands).  Now we want to put that line in a file called `bookshelf`.
	
	echo "The particle board of this bookshelf flexes under the weight of the books it holds, but it serves its purpose and does it cheaply." > bookshelf

Using the closing angle bracket `>` in this way is called redirection.  Every command that we run in the shell has an input, an output, an error output, and arguments/operands.  We are saying:  "Run `echo` with this string as an operand, and take the output and put it in a new file called bookshelf."  Try running `ls` again, and `cat` our new file.  

Adapted from [http://en.flossmanuals.net/command-line/piping/](http://en.flossmanuals.net/command-line/piping/)

#### Piping

Let's look back at our books.  Read out the file.  Notice that the list of books is unsorted!  We need to organize this using the `sort` command.

Try `cat books`, and `cat books | sort`.  The character `|` is called the pipe.  We take the output from `cat books` and send it through a pipe to `sort`.  The output of `cat books` becomes the input of `sort`.  Now send the output of `sort` to a file:

	cat books | sort > sorted_books

Look around again to see how the room has changed.

There are dozens of powerful tools we can leverage using pipes.  One of the ones you'll be using the most is `grep`.

	cat books | grep Mil
	
See how we filtered out just the lines that contain Mil?  Try grepping for something else.

#### Moving 

Now that we have our books sorted, we really don't need our unsorted list of books.  `mv` stands for move, and that's how we move files and folders from place to place.

	mv sorted_books books
	
Look around and see how the room has changed.

#### Copying 
To copy files, we use the `cp` command.  Extrapolate from the way we used `mv` to copy the file `bookshelf` to add a file `second_bookshelf`.

#### Removing
`rm` is short for remove.  Use `rm` to remove the `second_bookshelf` file we just created with `cp`.

#### The Shell is Programming

In interacting with the terminal like we did today, we've been using a programming language called __bash__, which stands for _Bourne-again shell_.  There are many different shell languages, but the commands we went over today will work in almost any.  Another common shell is __zsh__.  

The fact that we interact with the computer by programming empowers us. Instead of struggling to talk about the difference between two menus in a graphical program, we can communicate precisely about shell commands that have a predictable effect.

#### What happens when you run a command?

Sometimes it's important to know how the shell finds the commands that you run.  The command `which [command-name]` will tell you the location of the file which will be run when you execute that command.  For example, `which rm` on my computer gives `/bin/rm`.

`which ruby` gives `/Users/raphael/.rvm/rubies/ruby-2.0.0-p247/bin/ruby`

The shell finds these commands by looking at the PATH variable in the shell.  `echo $PATH` will show you the contents of PATH.  It should be a list of directories separated by `:`.  When you run any command, the shell looks in the directories for files that match the name of the command you're trying to run, and executes the first one it finds.  Most of you should have a line changing PATH in your `~/.bash_profile` file, which is run every time you open a new terminal session (tab or window).

#### Further Reading
Linux is almost the same as OSX, and this is a great manual about the Linux command line:

[The GNU Guide to the Command Line](http://en.flossmanuals.net/command-line/)

Here's a starter book on using the command line:

[The Command Line Crash Course](http://cli.learncodethehardway.org/book/)

Here's an interesting anecdote about why Standard Output and Standard Error are separate:

[The Birth of Standard Error](http://spinellis.gr/blog/20131211/)

## Everything is Text (Almost)

Programs and code are basically all text.  We can edit them with any text editor.   We want an editor that's easy to use but has a programmer's features.  Some document editors are not text editors.  For example, Microsoft Word saves files by default in the Microsoft Word Document format which is not text, and we can't view it using `cat` and `grep`, and can't manipulate it using a text editor.

We use Sublime Text because it's easy, has been extended to be good for editing a lot of programming languages, and it's made for programmers.  

You also might see Vim or other terminal editors, which are good because they don't require a graphical (non-command line) interface to use, so we can use them over the internet to edit files on remote servers, and to edit files in the context of terminal commands.

Files are files, names are just names, file extensions are just a convenience so programs like Sublime Text can be smart about showing the files to you, it doesn't make a difference when it comes to running them.

Programmer's editors have many features that editors like Word do not have, like:
  
  - Auto-reindentation.  Edit -> Line -> Reindent in Sublime Text will reindent code to make it more readable.
  - Syntax highlighting.  Sublime Text will show code in helpful colors to make it more readable.
  - Parenthesis matching. Sublime text will show you the matching close parenthesis when you highlight an open parenthesis, and vice versa.
  
Sublime Text's settings can be adjusted.  Be proactive in making your environment comfortable and you will become more productive.


 
