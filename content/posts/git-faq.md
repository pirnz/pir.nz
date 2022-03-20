---
title: "Git FAQ"
tags:
- git
date: 2022-03-20
toc: true
draft: false
description: Questions that I've had working with git
---

## Add a local repository to GitHub

Following the instructions from [GitHub docs](https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/adding-locally-hosted-code-to-github).

Set a local repo:

```bash
$ git init -b main
$ git add -A
$ git commit -m “init commit”
```

Add remote:

```bash
$ git remote add origin  <REMOTE_URL>
# Sets the new remote
$ git remote -v
# Verifies the new remote URL
```
Push repository:

```bash
$ git push origin main
# Pushes the changes in your local repository up to the remote repository you specified as the origin
```

## Use different author info for each repo

Using the git commands:

```bash
$ git config user.name yourusername
$ git config user.email your@mail.com
```

They will take over the values you might have set in the `--global` configuration.

Check the current configuration with `git config --list`. The global confuration shows first, then the local. Check the last appearence of `user.email` and `user.name`.

## How to change the username and email of previous commits

```bash
$ git rebase -i --root -x "git commit --amend --author 'Author Name <author.name@mail.com>' --no-edit"
```
From Stackoverflow: [Change git email for previous commits](https://stackoverflow.com/questions/34850831/change-git-email-for-previous-commits) and [Change first commit of project with Git?](https://stackoverflow.com/questions/2246208/change-first-commit-of-project-with-git)

- Keep the `<>` around the email