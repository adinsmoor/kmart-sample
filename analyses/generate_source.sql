{{ codegen.generate_source('TPCH_SF001','raw') }}

-- dbt run-operation generate_source --args '{"schema_name": "TPCH_SF001", "database_name": "raw", "generate_columns":"True", "include_descriptions":"True"}'
