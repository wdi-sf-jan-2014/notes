# Git in a Team

## Agenda
* The Importance of Workflow
* Git Branch
* Our workflow
* Git Status - Self Awareness


## Note on Git Setup:

Color everywhere:
`git config --global color.ui true`

Aliases for pretty graphs (add these to ~/.gitconfig and run `git lg1` or `git lg2`):

```
[alias]
lg1 = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
```

## The Importance of Workflow

With multiple people working, everyone must conform to a workflow which will cause others a minimum of confusion.  Half-finished features and prototype ideas have to exist, but they have to be kept clear of the main working branch.  Time spent merging should be minimized and the commit history should remain clear.

## Git Branch

What is a branch?  A name for a commit which moves forward to the child commit as we go.  It is a name for one _working tip_.  So far, you have all been working in the master branch, and pushing back to the master branch.  We are going to use branches to enable us to work on features independently and merge cleanly.

View local branches:
`git branch`

Creating and moving to a new branch:
`git checkout -b <branch_name>`

Moving to an existing branch:
`git checkout <branch_name>`

Deleting a branch in your local repository:
`git branch -d <branch_name>` or `-D` to force delete.

## Our Workflow

We will have one central repository which one group member will own.  Everyone else will have a fork.  Nobody, including the repository owner, will commit directly to the master branch.  Instead, we will use feature branches.

### Setup
1. One team member (A) will create the repository and clone it.  A will also add the other team members as collaborators.
2. Each other team member (B) will fork the repository and clone their fork.
3. The non owners (B), should add the upstream repository as a remote to their git repository.  `git remote add upstream <A's repository URL>`
4. One team member (it can be anyone) will create a Heroku app and add the rest of the team as collaborators.
5. Everyone will add the heroku url as a remote to their git repository: `git remote add heroku <heroku url>`.  This is available on your heroku dashboard.

### Development
1. When you're working on a feature, start a branch with an informative name.  This is called a feature branch.  `git checkout -b <new_feature_branch_name>`
2. Work, commit, and push to your feature branch until you have some working code which it makes sense to pull in.   To push to your feature branch, run `git push origin <feature_branch_name>` while you have the feature branch checked out.
3. When you're ready to pull in, go to github.com, and make a pull request from your branch to the master branch of the original (A's) repository.  If you are the owner of the repository, you will still make a pull request from your feature branch into the master branch.  
4. Someone else will review the pull request.  If you are reviewing a pull request, give line by line comments and ask the pull request sender
5. If someone updates a PR you have commented on, review it again ASAP.
6. Once the PR looks good, the reviewer will merge it into master:
	1. `git checkout master`
	2. `git fetch origin`
	3. `git merge origin/<feature_branch>`
	4. `git push origin master`

	Or do it through the web interface.

5. Whoever merges the pull request will push the new code to Heroku. `git push heroku master`

### This means:
* Don't commit while the master branch is checked out
* Take responsibility for merging other people's pull requests (PR).  Review their code for errors.  Even if you trust their competence, they may have left in a `binding.pry` or an empty test file.
* If someone comments on your PR, resolve the issue with a commit or several commits in your feature branch, then push to your feature branch on github.  This will update the PR.

## Git Status

It's not enough to commit to following the workflow.  You must also stay aware of the current state of your repository so that when you make mistakes, you can recover.  Use `git status` constantly.  

## Resources:
How Github uses Github:
http://zachholman.com/talk/how-github-uses-github-to-build-github/

The Pro Git book:
[http://git-scm.com/book/](http://git-scm.com/book/)

An example git workflow for a project with a running production server:
[http://nvie.com/posts/a-successful-git-branching-model/](http://nvie.com/posts/a-successful-git-branching-model/)