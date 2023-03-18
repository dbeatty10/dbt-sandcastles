# Example

This dbt project is an example of upgrading an [analysis](https://docs.getdbt.com/docs/build/analyses) to be [referenced in an exposure](https://docs.getdbt.com/reference/exposure-properties).

## Install
Create a virtual environment and install dependencies using `bash`/`zsh` (or [your OS shell of choice](docs/virtual-environment.md)):

```shell
python3 -m venv env
source env/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
source env/bin/activate
```

## Enable `ref` for analysis files   

Do an initial compilation of the analyses:
```shell
dbt compile
```

Create folder for the analyes that we want to `ref`:

```shell
echo "
models:
  my_dbt_project:
      refable_analyses:
        materialized: ephemeral" >> dbt_project.yml
```

Move all the analyses into the new folder:

```shell
mv analyses models/refable_analyses
```

Within any [YAML config files for analyses](https://docs.getdbt.com/reference/analysis-properties), move anything under the `analyses:` key to be under `models:` instead. In this case, `models/refable_analyses/_analyses.yml`.

Compile again (which will include the analyses):
```shell
dbt compile
```

Compare the compiled analyses with the compiled ephemeral models:
```shell
diff target/compiled/my_dbt_project/models/refable_analyses target/compiled/my_dbt_project/analyses/
```

Add in an exposure
```shell
echo "
exposures:
  - name: my_even_dashboard
    description: My dashboard
    type: dashboard
    owner:
      name: Somebody Somewhere
      email: somebody@somewhere.com
    
    depends_on:
      - ref('my_even_ids')" >> models/refable_analyses/_analyses.yml
```

Look at the docs:
```shell
dbt docs generate
dbt docs serve
```
