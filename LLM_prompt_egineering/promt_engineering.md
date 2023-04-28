# Prompt engineering for large language models

- [Prompt engineering for large language models](#prompt-engineering-for-large-language-models)
  - [Guidelines for prompting](#guidelines-for-prompting)
    - [Principle 1](#principle-1)
      - [Delimiters](#delimiters)
      - [Ask for a strucrured output](#ask-for-a-strucrured-output)
      - [Checking whether conditions are satisfied](#checking-whether-conditions-are-satisfied)
      - [Few shot prompting](#few-shot-prompting)
  - [Principle 2](#principle-2)


It is very important to know how to interact with `LLMs` to get the most out of each and every API call.

A few interesting things to consider when asking an `LLM` a question:

1. What context are you asking about? 
2. In what style should the model answer?
3. Are there any references that you wish the model to use?

## Guidelines for prompting

The first principle is to give **clear** and **specific** instructions.

The second is to give the model time to *"think"*.

### Principle 1

#### Delimiters

Use **delimiters** to clearly indicate distinct parts of the inpiut, such as: ` ``` `, `"""`, `<>`, `<tag> <tag/>`

```python
text = f"""
You should express what you want a model to do by \ 
providing instructions that are as clear and \ 
specific as you can possibly make them. \ 
This will guide the model towards the desired output, \ 
and reduce the chances of receiving irrelevant \ 
or incorrect responses. Don't confuse writing a \ 
clear prompt with writing a short prompt. \ 
In many cases, longer prompts provide more clarity \ 
and context for the model, which can lead to \ 
more detailed and relevant outputs.
"""
prompt = f"""
Summarize the text delimited by triple backticks \ 
into a single sentence.
```{text}```
"""
```

This helps avoid `prompt injections`, that is to say to avoid conflicting instructions to the LLM via the text.

#### Ask for a strucrured output

This allows us to have a structured and consistent output, this could be read directly into a file.

```python
prompt = f"""
Generate a list of three made-up book titles along \ 
with their authors and genres. 
Provide them in JSON format with the following keys: 
book_id, title, author, genre.
"""
```

This would output something like:

```json
[
  {
    "book_id": 1,
    "title": "The Lost City of Zorath",
    "author": "Aria Blackwood",
    "genre": "Fantasy"
  },
  {
    "book_id": 2,
    "title": "The Last Hope",
    "author": "Ethan Stone",
    "genre": "Science Fiction"
  },
  {
    "book_id": 3,
    "title": "The Secret of the Blue Moon",
    "author": "Lila Rose",
    "genre": "Mystery"
  }
]
```

#### Checking whether conditions are satisfied

Asking the model to check whether conditions are satisfied allows us to make and enforce assumptions on inputs. This can handle edge cases too.

```python
text_1 = f"""
Making a cup of tea is easy! First, you need to get some \ 
water boiling. While that's happening, \ 
grab a cup and put a tea bag in it. Once the water is \ 
hot enough, just pour it over the tea bag. \ 
Let it sit for a bit so the tea can steep. After a \ 
few minutes, take out the tea bag. If you \ 
like, you can add some sugar or milk to taste. \ 
And that's it! You've got yourself a delicious \ 
cup of tea to enjoy.
"""
prompt = f"""
You will be provided with text delimited by triple quotes. 
If it contains a sequence of instructions, \ 
re-write those instructions in the following format:

Step 1 - ...
Step 2 - …
…
Step N - …

If the text does not contain a sequence of instructions, \ 
then simply write \"No steps provided.\"

\"\"\"{text_1}\"\"\"
"""
```

Would have an ourput like:

```text
Completion for Text 1:
Step 1 - Get some water boiling.
Step 2 - Grab a cup and put a tea bag in it.
Step 3 - Once the water is hot enough, pour it over the tea bag.
Step 4 - Let it sit for a bit so the tea can steep.
Step 5 - After a few minutes, take out the tea bag.
Step 6 - Add some sugar or milk to taste.
Step 7 - Enjoy your delicious cup of tea!
```

#### Few shot prompting

This is the practice of providing examples of what you expect the model to do within the prompt. This allows for less variation in the output of the prompt.

```python
prompt = f"""
Your task is to answer in a consistent style.

<child>: Teach me about patience.

<grandparent>: The river that carves the deepest \ 
valley flows from a modest spring; the \ 
grandest symphony originates from a single note; \ 
the most intricate tapestry begins with a solitary thread.

<child>: Teach me about resilience.
"""
```

Would have an output like:

```text
<grandparent>: Resilience is like a tree that bends with the wind but never breaks. It is the ability to bounce back from adversity and keep moving forward, even when things get tough. Just like a tree that grows stronger with each storm it weathers, resilience is a quality that can be developed and strengthened over time.
```

## Principle 2