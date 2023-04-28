# Prompt engineering for large language models

- [Prompt engineering for large language models](#prompt-engineering-for-large-language-models)
  - [Guidelines for prompting](#guidelines-for-prompting)
    - [Principle 1](#principle-1)
      - [Delimiters](#delimiters)
      - [Ask for a strucrured output](#ask-for-a-strucrured-output)
      - [Checking whether conditions are satisfied](#checking-whether-conditions-are-satisfied)
      - [Few shot prompting](#few-shot-prompting)
    - [Principle 2](#principle-2)
      - [Specify the steps required to complete the task](#specify-the-steps-required-to-complete-the-task)
      - [Instruct the model to work out it's own solution before rushing to a conclusion](#instruct-the-model-to-work-out-its-own-solution-before-rushing-to-a-conclusion)
    - [Model limitations](#model-limitations)
      - [Hallucinations](#hallucinations)
  - [Prompt development](#prompt-development)
    - [Example: Generate product description from a fact sheet](#example-generate-product-description-from-a-fact-sheet)
      - [Iteration 1: The output text is too long](#iteration-1-the-output-text-is-too-long)
      - [Iteration 2: Text focuses on wrong details](#iteration-2-text-focuses-on-wrong-details)
      - [Iteration 3: Description needs a table of dimensions](#iteration-3-description-needs-a-table-of-dimensions)
  - [Summarising](#summarising)
    - [Summarise with word/sentence/character limit](#summarise-with-wordsentencecharacter-limit)
    - [Summarise with a focus on the shipping and delivery](#summarise-with-a-focus-on-the-shipping-and-delivery)
    - [Summarise witha focus on price and value](#summarise-witha-focus-on-price-and-value)
    - [Extraction](#extraction)

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
<grandparent>: Resilience is like a tree that bends with the wind but never breaks.
 It is the ability to bounce back from adversity and keep moving forward, even when things get tough. 
 Just like a tree that grows stronger with each storm it weathers, resilience is a quality that can be developed and strengthened over time.
```

### Principle 2

#### Specify the steps required to complete the task

This allows the model to complete a complex task exactly how you wish for it to be completed. Specificity is very important.

```python
text = f"""
In a charming village, siblings Jack and Jill set out on \ 
a quest to fetch water from a hilltop \ 
well. As they climbed, singing joyfully, misfortune \ 
struck—Jack tripped on a stone and tumbled \ 
down the hill, with Jill following suit. \ 
Though slightly battered, the pair returned home to \ 
comforting embraces. Despite the mishap, \ 
their adventurous spirits remained undimmed, and they \ 
continued exploring with delight.
"""
# example 1
prompt_1 = f"""
Perform the following actions: 
1 - Summarize the following text delimited by triple \
backticks with 1 sentence.
2 - Translate the summary into French.
3 - List each name in the French summary.
4 - Output a json object that contains the following \
keys: french_summary, num_names.

Separate your answers with line breaks.

Text:
```{text}```
"""
```

which would output:

```text
Completion for prompt 1:
Two siblings, Jack and Jill, go on a quest to fetch water from a well on a hilltop, but misfortune strikes and they both tumble down the hill, returning home slightly battered but with their adventurous spirits undimmed.

Deux frères et sœurs, Jack et Jill, partent en quête d'eau d'un puits sur une colline, mais un malheur frappe et ils tombent tous les deux de la colline, rentrant chez eux légèrement meurtris mais avec leurs esprits aventureux intacts. 
Noms: Jack, Jill.

{
  "french_summary": "Deux frères et sœurs, Jack et Jill, partent en quête d'eau d'un puits sur une colline, mais un malheur frappe et ils tombent tous les deux de la colline, rentrant chez eux légèrement meurtris mais avec leurs esprits aventureux intacts.",
  "num_names": 2
}
```

Another such prompt could be:

```python
prompt_2 = f"""
Your task is to perform the following actions: 
1 - Summarize the following text delimited by 
  <> with 1 sentence.
2 - Translate the summary into French.
3 - List each name in the French summary.
4 - Output a json object that contains the 
  following keys: french_summary, num_names.

Use the following format:
Text: <text to summarize>
Summary: <summary>
Translation: <summary translation>
Names: <list of names in Italian summary>
Output JSON: <json with summary and num_names>

Text: <{text}>
"""
```

Which asks for a much more structured answer and leads to this output:

```text
Completion for prompt 2:
Summary: Jack and Jill go on a quest to fetch water, but misfortune strikes and they tumble down the hill, returning home slightly battered but with their adventurous spirits undimmed. 
Translation: Jack et Jill partent en quête d'eau, mais la malchance frappe et ils dégringolent la colline, rentrant chez eux légèrement meurtris mais avec leurs esprits aventureux intacts.
Names: Jack, Jill
Output JSON: {"french_summary": "Jack et Jill partent en quête d'eau, mais la malchance frappe et ils dégringolent la colline, rentrant chez eux légèrement meurtris mais avec leurs esprits aventureux intacts.", "num_names": 2}
```

#### Instruct the model to work out it's own solution before rushing to a conclusion

We can get better results this way, as the model has time to consider multiple view points and approaches to a problem.

Here is an example:

```python
prompt = f"""
Determine if the student's solution is correct or not.

Question:
I'm building a solar power installation and I need \
 help working out the financials. 
- Land costs $100 / square foot
- I can buy solar panels for $250 / square foot
- I negotiated a contract for maintenance that will cost \ 
me a flat $100k per year, and an additional $10 / square \
foot
What is the total cost for the first year of operations 
as a function of the number of square feet.

Student's Solution:
Let x be the size of the installation in square feet.
Costs:
1. Land cost: 100x
2. Solar panel cost: 250x
3. Maintenance cost: 100,000 + 100x
Total cost: 100x + 250x + 100,000 + 100x = 450x + 100,000
"""
```

Then we ask the model to evaluate the solution.

```text
The student's solution is correct
```

Now this is wrong. What if we asked the model to work out its own solution first

```python
prompt = f"""
Your task is to determine if the student's solution \
is correct or not.
To solve the problem do the following:
- First, work out your own solution to the problem. 
- Then compare your solution to the student's solution \ 
and evaluate if the student's solution is correct or not. 
Don't decide if the student's solution is correct until 
you have done the problem yourself.

Use the following format:
Question:...
question here...
Student's solution:...
student's solution here...
Actual solution:...
steps to work out the solution and your solution here...
Is the student's solution the same as actual solution \
just calculated:...
yes or no...
Student grade:...
correct or incorrect...

Question:
...
I'm building a solar power installation and I need help \
working out the financials. 
- Land costs $100 / square foot
- I can buy solar panels for $250 / square foot
- I negotiated a contract for maintenance that will cost \
me a flat $100k per year, and an additional $10 / square \
foot
What is the total cost for the first year of operations \
as a function of the number of square feet.
...
Student's solution:
...
Let x be the size of the installation in square feet.
Costs:
1. Land cost: 100x
2. Solar panel cost: 250x
3. Maintenance cost: 100,000 + 100x
Total cost: 100x + 250x + 100,000 + 100x = 450x + 100,000
...
Actual solution:
"""
```

This much more **specific** prompt actually leads to the correct solution.

### Model limitations

#### Hallucinations

A `hallucination` in a `LLM` is essentially a statement that sounds plausible but is not true.

```python
prompt = f"""
Tell me about AeroGlide UltraSlim Smart Toothbrush by Boie
"""
```

The product does not exist but the model responds with:

```text
The AeroGlide UltraSlim Smart Toothbrush by Boie is a high-tech toothbrush that uses advanced sonic technology to provide a deep and thorough clean. It features a slim and sleek design that makes it easy to hold and maneuver, and it comes with a range of smart features that help you optimize your brushing routine.

One of the key features of the AeroGlide UltraSlim Smart Toothbrush is its advanced sonic technology, which uses high-frequency vibrations to break up plaque and bacteria on your teeth and gums. This technology is highly effective at removing even the toughest stains and buildup, leaving your teeth feeling clean and fresh.

In addition to its sonic technology, the AeroGlide UltraSlim Smart Toothbrush also comes with a range of smart features that help you optimize your brushing routine. These include a built-in timer that ensures you brush for the recommended two minutes, as well as a pressure sensor that alerts you if you're brushing too hard.

Overall, the AeroGlide UltraSlim Smart Toothbrush by Boie is a highly advanced and effective toothbrush that is perfect for anyone looking to take their oral hygiene to the next level. With its advanced sonic technology and smart features, it provides a deep and thorough clean that leaves your teeth feeling fresh and healthy.
```

We can reduce these by doing the following to your prompt:

- First find relevant information
- Answer the question based on relevent information

## Prompt development

When it comes to `prompt development` the process is iterative, meaning that we develop them in a cycle that goes from:

1. Idea
2. Implementation of prompt
3. Experimental result
4. Error analysis
5. Repeat!

This framework allows us to refine our model as much as we please.

### Example: Generate product description from a fact sheet

```python
fact_sheet_chair = """
OVERVIEW
- Part of a beautiful family of mid-century inspired office furniture, 
including filing cabinets, desks, bookcases, meeting tables, and more.
- Several options of shell color and base finishes.
- Available with plastic back and front upholstery (SWC-100) 
or full upholstery (SWC-110) in 10 fabric and 6 leather options.
- Base finish options are: stainless steel, matte black, 
gloss white, or chrome.
- Chair is available with or without armrests.
- Suitable for home or business settings.
- Qualified for contract use.

CONSTRUCTION
- 5-wheel plastic coated aluminum base.
- Pneumatic chair adjust for easy raise/lower action.

DIMENSIONS
- WIDTH 53 CM | 20.87”
- DEPTH 51 CM | 20.08”
- HEIGHT 80 CM | 31.50”
- SEAT HEIGHT 44 CM | 17.32”
- SEAT DEPTH 41 CM | 16.14”

OPTIONS
- Soft or hard-floor caster options.
- Two choices of seat foam densities: 
 medium (1.8 lb/ft3) or high (2.8 lb/ft3)
- Armless or 8 position PU armrests 

MATERIALS
SHELL BASE GLIDER
- Cast Aluminum with modified nylon PA6/PA66 coating.
- Shell thickness: 10 mm.
SEAT
- HD36 foam

COUNTRY OF ORIGIN
- Italy
"""

prompt = f"""
Your task is to help a marketing team create a 
description for a retail website of a product based 
on a technical fact sheet.

Write a product description based on the information 
provided in the technical specifications delimited by 
triple backticks.

Technical specifications: ```{fact_sheet_chair}```
"""
```

#### Iteration 1: The output text is too long

We need to limit the nimber of words/sentences/characters, we can implement this in the prompt:

```python
prompt = f"""
Your task is to help a marketing team create a 
description for a retail website of a product based 
on a technical fact sheet.

Write a product description based on the information 
provided in the technical specifications delimited by 
triple backticks.

Use at most 50 words.

Technical specifications: ```{fact_sheet_chair}```
"""
```

This results in a much shorter output of:

```text
Introducing our mid-century inspired office chair, part of a beautiful furniture family. 
Available in various shell colors and base finishes, with plastic or full upholstery options in fabric or leather.
Suitable for home or business use, with a 5-wheel base and pneumatic chair adjust. 
Made in Italy. (47 words)
```

#### Iteration 2: Text focuses on wrong details

Here we can solve this isue by being more **specific** within the query:

```python
prompt = f"""
Your task is to help a marketing team create a 
description for a retail website of a product based 
on a technical fact sheet.

Write a product description based on the information 
provided in the technical specifications delimited by 
triple backticks.

The description is intended for furniture retailers, 
so should be technical in nature and focus on the 
materials the product is constructed from.

Use at most 50 words.

Technical specifications: ```{fact_sheet_chair}```
"""
response = get_completion(prompt)
print(response)
```

Which leads to the output:

```text
Introducing our mid-century inspired office chair, perfect for both home and business settings. 
With a range of shell colors and base finishes, including stainless steel and matte black, 
this chair is available with or without armrests. 
The 5-wheel plastic coated aluminum base and pneumatic chair adjust make it easy to move and 
adjust to your desired height. 
Made with high-quality materials, 
including a cast aluminum shell and HD36 foam seat, 
this chair is built to last.
```

#### Iteration 3: Description needs a table of dimensions

We can then get it to organise the output into a table.

```python
prompt = f"""
Your task is to help a marketing team create a 
description for a retail website of a product based 
on a technical fact sheet.

Write a product description based on the information 
provided in the technical specifications delimited by 
triple backticks.

The description is intended for furniture retailers, 
so should be technical in nature and focus on the 
materials the product is constructed from. The decription
should be at most 50 words.

At the end of the description, include every 7-character 
Product ID in the technical specification.

After the description, include a table that gives the 
product's dimensions. The table should have two columns.
In the first column include the name of the dimension. 
In the second column include the measurements in inches only.

Give the table the title 'Product Dimensions'.

Format everything as HTML that can be used in a website. 
Place the description in a <div> element.

Technical specifications: ```{fact_sheet_chair}
```

This leads to the following amazing output:

<div>
<p>Introducing our mid-century inspired office chair, part of a beautiful family of furniture. Available in multiple shell colors and base finishes, with plastic or full upholstery options. Suitable for home or business settings and qualified for contract use. Product ID: SWC-100, SWC-110.</p>
<table>
  <caption>Product Dimensions</caption>
  <tr>
    <th>Width</th>
    <td>53 cm | 20.87"</td>
  </tr>
  <tr>
    <th>Depth</th>
    <td>51 cm | 20.08"</td>
  </tr>
  <tr>
    <th>Height</th>
    <td>80 cm | 31.50"</td>
  </tr>
  <tr>
    <th>Seat Height</th>
    <td>44 cm | 17.32"</td>
  </tr>
  <tr>
    <th>Seat Depth</th>
    <td>41 cm | 16.14"</td>
  </tr>
</table>
</div>

## Summarising

We can use `LLMs` to summarise text, this is mega useful for research papers or documents.

The text:

```python
prod_review = """
Got this panda plush toy for my daughter's birthday, \
who loves it and takes it everywhere. It's soft and \ 
super cute, and its face has a friendly look. It's \ 
a bit small for what I paid though. I think there \ 
might be other options that are bigger for the \ 
same price. It arrived a day earlier than expected, \ 
so I got to play with it myself before I gave it \ 
to her.
"""
```

### Summarise with word/sentence/character limit

```python
prompt = f"""
Your task is to generate a short summary of a product \
review from an ecommerce site. 

Summarize the review below, delimited by triple 
backticks, in at most 30 words. 

Review: ```{prod_review}```
"""
```

result:

```text
Soft and cute panda plush toy loved by daughter, but a bit small for the price. Arrived early.
```

### Summarise with a focus on the shipping and delivery

```python
prompt = f"""
Your task is to generate a short summary of a product \
review from an ecommerce site to give feedback to the \
Shipping deparmtment. 

Summarize the review below, delimited by triple 
backticks, in at most 30 words, and focusing on any aspects \
that mention shipping and delivery of the product. 

Review: ```{prod_review}```
"""
```

result:

```text
he panda plush toy arrived a day earlier than expected, but the customer felt it was a bit small for the price paid.
```

### Summarise witha focus on price and value

```python
prompt = f"""
Your task is to generate a short summary of a product \
review from an ecommerce site to give feedback to the \
pricing deparmtment, responsible for determining the \
price of the product.  

Summarize the review below, delimited by triple 
backticks, in at most 30 words, and focusing on any aspects \
that are relevant to the price and perceived value. 

Review: ```{prod_review}```
"""
```

result:

```text
The panda plush toy is soft, cute, and loved by the recipient, but the price may be too high for its size.
```

### Extraction

We can also extract information from text instead.

```python
prompt = f"""
Your task is to extract relevant information from \ 
a product review from an ecommerce site to give \
feedback to the Shipping department. 

From the review below, delimited by triple quotes \
extract the information relevant to shipping and \ 
delivery. Limit to 30 words. 

Review: ```{prod_review}```
"""
```

results:

```text
The product arrived a day earlier than expected.

```
