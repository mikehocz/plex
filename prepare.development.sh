#!/usr/bin/env bash

script_path="$(cd $(dirname "$0"); pwd)"

NODE_LCS="${NODE_LCS:-development}"
source $script_path/config/config.$NODE_LCS.sh

source build.sh

echo 'Install and use utPLSQL'     
pushd lib/submodule/utPLSQL/source
sqlplus -S -L /nolog << EOF
connect ceos_utplsql/cmd@${ORACLE_CONNECT_STRING}
--@install.sql ceos_utplsql
@create_user_grants.sql ceos_utplsql plex_000100
EOF

sqlplus -S -L /nolog << EOF
connect plex_000100/PLEX_000100@${ORACLE_CONNECT_STRING}
@create_user_synonyms ceos_utplsql plex_000100
EOF
popd