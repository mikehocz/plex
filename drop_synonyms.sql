rem
rem Drops synonyms for your public API (packages, views, ...) in user which is using your package
rem
rem Usage
rem     SQL > @uncreate_synonyms.sql <schema name>
rem
rem Options
rem
rem     schema name - where your package is installed with public API
rem
set verify off
define l_schema_name = "&1"

rem Load package
@@package.sql

prompt Drop synonyms in &&g_current_schema schema for API objects of &&g_package_name package installed in &&l_schema_name schema
@module/api/drop_synonyms.sql

rem undefine locals
undefine l_schema_name

rem undefine package globals
@@undefine_globals.sql
