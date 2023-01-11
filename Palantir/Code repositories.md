# Overview

`Code repositories` in Foundry are codebases where you can store and organise all of your transformations of data in a pipeline. These contain version control and branching elements.

To fully test code and save the output we need to `build` the code in the Foundry IDE.

Python files in `code repositories` always have a code block at the start that specifies the `source` and the `output` paths for the data in the following way:

```python
from transforms.api import transform_df, Input, Output

@transform_df(
			  Output(OUTPUT_DATASET_PATH),
			  source_df = Input(SOURCE_DATASET_PATH)
)

# ALL CODE IS RUN FROM THE COMPUTE FUNCTION

def compute(df):
	return df
```

