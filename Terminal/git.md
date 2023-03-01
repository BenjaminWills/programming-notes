# Git

## Topics

- [Logs](#logs "Logs")
- [Commit](#commit "Commit")
- [Branches](#branches "Branches")
- [Push](#push "Push")
- [Revert](#revert "Revert")

## Logs [^](#topics "Topics")

All

```zsh
git log
```

Single

```zsh
git log -oneline
```

## Commit [^](#topics "Topics")

Status

```zsh
git status
```

Staging

```zsh
git add .
```

Commit

```zsh
git commit -m"message"
```

## Branches [^](#topics "Topics")

List

```zsh
git branch -a
```

Create

```zsh
git branch [name]
```

Move

```zsh
git checkout [name]
```

Create/Move

```zsh
git checkout -b [name]
```

Delete unmerged

```zsh
git branch -D [name]
```

Merge

```zsh
git merge [branch]
```

Delete merged

```zsh
git branch -d [name]
```

## Push [^](#topics "Topics")

Local to Github

```zsh
git push origin [branch]
```

## Revert [^](#topics "Topics")

Previous commit

```zsh
git reset -hard [log number]
```
