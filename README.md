# dbt-sandcastles

Inspired and modeled after https://github.com/jeremyyeo/dbt-sandcastles.

## Install

Clone this repo using your favorite method: HTTPS, SSH, or GitHub CLI.

```shell
cd dbt-sandcastles
```

## Setup profiles.yml

Configure a connection named `TODO` within your `profiles.yml`.

### Initial setup of virtual environment

```shell
python3 -m venv venv
source venv/bin/activate
python3 -m pip install --upgrade pip
```

### dbt-snowflake 1.2.0

Start with dbt 1.2:
```shell
python3 -m pip install dbt-snowflake==1.2.0
source venv/bin/activate
dbt --version
```

### Run

Build from scratch:
```shell
dbt build --full-refresh
```

Run again (incrementally):
```shell
dbt build -s test_incremental
```

### dbt-snowflake 1.3.0

Change the version of dbt to 1.3:
```shell
python3 -m pip install dbt-snowflake==1.3.0
source venv/bin/activate
dbt --version
```

### Run again

```shell
dbt build -s test_incremental
```

If the build generates an error, try adding the following to the config block within `models/test_incremental.sql`:
```sql
unique_key='id',
```

And then re-run:
```shell
dbt build -s test_incremental
```

If the previous build fails but the last one works, then the cause of the error has been localized to [here](https://github.com/dbt-labs/dbt-snowflake/blob/65e282282a23578ac1083548356f55fba6959ea9/dbt/include/snowflake/macros/materializations/incremental.sql#L13-L17).
