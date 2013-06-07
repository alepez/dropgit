DropGit
=======

> *DropGit* Automagically put on git version control system a Dropbox folder.

## Usage

Go to the directory you need to control with git and connect it
with a remote repository!

    cd ~/Dropbox/my_project
    dropgit init git@github.com:username/my_project.git

Start *DropGit* daemon, it will push and pull automatically
when it detects updates.

    dropgit start

You can stop the daemon whenever you want:

    dropgit stop

## Multiple repositories

You can add has many directories as you want, just initialize it:

    cd ~/Dropbox/my_other_project
    dropgit init git@github.com:my-username/my_other_project.git

You can list all repositories managed by dropgit:

    dropgit list

## Local repositories

Local repositories aren't stored inside your dropbox directory,
but inside your home: `~/.dropgit/repositories`. This to prevent
*Dropbox* messing up git database.

## Settings

The settings file is located in `~/.dropgit/settings`.
Editing it, you can change where to put new local repositories.

## Logs

Daemon's logs are located inside `~/.dropgit/daemon` directory.

