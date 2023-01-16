# Command Line

## Topics

- [General](#general "General")
- [Dictionary](#directory "Dictionary")
- [Files](#files "Files")
- [Search](#search "Search")
- [Cron](#cron "Cron")

## General [^](#topics "Topics")

Autocomplete

```zsh
# press tab
```

Clear

```zsh
clear
```

Manual

```zsh
man [command]
```

Admin privilege

```zsh
sudo [command]
```

Chain commands

```zsh
[command] | [command]
```

Separate commands

```zsh
[command] ; [command]
```

Wildcards

```zsh
# 0 or more characters
  *

# Single character
  ?

# Any character inside
  []
```

## Directory [^](#topics "Topics")

Current path

```zsh
pwd
```

Change directory

```zsh
cd [path]
```

- _root directory = **~**_
- _current directory = **.**_
- _previous directory = **..**_
- _nested directory = **/**_

List contents

```zsh
ls
```

- _detailed content = **-l**_
- _hidden content = **-a**_

Create directory

```zsh
mkdir [path]
```

- _nested directories = **-p**_

Remove empty directory

```zsh
rmdir [path]
```

Remove nested directories

```zsh
rm -r [path]
```

## Files [^](#topics "Topics")

Create

```zsh
touch [file]
```

Copy

```zsh
cp [file] [copy]
```

Move

```zsh
mv [file] [path]
```

Remove

```zsh
rm [path]
```

Open

```zsh
open [file]
```

Overwrite

```zsh
echo [output] > [file]
```

Append

```zsh
echo [output] >> [file]
```

Print

```zsh
cat [file]
```

- _top lines = **head -n [num] [file]**_
- _bottom lines = **tail -n [num] [file]**_
- _word count = **wc [file]**_

## Search [^](#topics "Topics")

Text

```zsh
grep "search" [file]
```

- _case-insensitive = **-i**_
- _all files in a directory = **-r**_

File

```zsh
find [directory] -name "search"
```

## Cron [^](#topics "Topics")

Editor

```zsh
crontab - e
```

List

```zsh
crontab -l
```

Delete

```zsh
crontab -r
```
