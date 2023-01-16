# Data Engineering

## Topics

- [Palantir Learning](#palantir-learning "Palantir Learning")
- [Data Engineering](#data-engineering-1 "Data Engineering")
- [Under the Hood](#under-the-hood "Under the Hood")

## Palantir Learning [^](#topics "Topics")

DATAENG 01: Data Pipeline Foundations

- Foundry 107 - Code Repositories
- Foundry 110 - Pipeline Builder: Getting Started
- Foundry 111 - Pipeline Builder: Production-Grade Pipelines

DATAENG 02 (Builder): Intro to Data Transformation  
DATAENG 02 (Repositories): Intro to Data Transformation

DATAENG 03 (Builder): Creating a Project Output  
DATAENG 03 (Repositories): Creating a Project Output

DATAENG 04: Scheduling Data Pipelines

DATAENG 05 (Builder): Transform Projects in Pipeline Builder  
DATAENG 05a (Repositories): Working with Raw Files  
DATAENG 05b (Repositories): Publishing and Using Shared Libraries  
DATAENG 05c (Repositories): Multiple Outputs with Data Transforms

DATAENG 06: Monitoring Data Pipeline Health

DATAENG 07 (Builder): Configuring Data Expectations  
DATAENG 07 (Repositories): Configuring Data Expectations

DATAENG 08 (Builder): Ontology Data Pipelines  
DATAENG 08 (Repositories): Ontology Data Pipelines

## Data Engineering [^](#topics "Topics")

Planning a Pipeline

- Clearly defined output and identified source data
- Gap between source data and data needed
- Keep data assets up to date with refreshing source data
- End-product adheres to service-level agreements (SLAs)

Creating a Pipeline

- Data connection = sync raw data from source to project
- Data source = inputs raw datasets and outputs clean datasets
- Transform = inputs clean datasets and outputs aggregated datasets
- Ontology = convert datasets into discrete business objects
- Workflow = create operational workflow using objects

Prototyping

- **Code Workbook** = interface/console to test SQL & Python
- **Contour** = no-code data analysis operations in notebook & dashboard
- **Preparation** = no-code environment to test data cleaning steps

Transforming

- **Pipeline Builder** = low/no-code pipeline development
- **Code Repositories** = specialised code-based pipeline development

Maintaining

- **Data Lineage** = explore data flow
  - Can create schedules
  - Can add health checks
- **Scheduler** = defined time/event-based triggers
- **Data Health** = monitoring & alerts for defined conditions
- **Job Tracker** = monitor jobs (individual transforms) or builds (unit of jobs)

Ontology

- **Object Explorer** = view object properties & links
- **Ontology Manager** = manage objects

## Under the Hood [^](#topics "Topics")

Loading Data = Data Connection App

- Cloud Source
  - Configure credentials
  - Sync query parameters
- External Source
  - Install a Data Connection Agent intermediary
  - Configure credentials through agent
  - Sync query parameters

Sync

- Build = modifies datasets through transactions
- Transaction = atomic changes to datasets
  - Snapshot/Replace = contain whole datasets used within a transaction
  - Append = only contains data necessary for a transaction
- Storage contains all historical transactions

Processing Data (necessary to create an ontology)

- Job Spec applies consistent schema
- Builds use jobs to publish data
- Commit/Merge changes to main branch

Operationalising Data (application builders)

- Abstractions over data
  - Object Type = dataset
  - Object Property Type = column
  - Object = row
  - Object Property = value
- Specify searchable vs sortable properties
  - Optimise indexing
- Object Sets = collection of objects matching a query
  - Uses indexing and arrays
- Actions = reusable logic to edit objects
  - Edits overwrite transactions since it overwrites backing datasets
- Writeback Datasets = processes all user edited data

Exporting Data (networking)

- Webhooks = send small requests
  - Actions trigger webhooks
  - Data Connection App & Data Connection Agent
- Exports = apply large updates
  - Uses Writeback Datasets
  - Data Connection App & Data Connection Agent
- Palantir API = query object storage
