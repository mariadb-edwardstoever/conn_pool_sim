#!/usr/bin/env bash
# conn_pool_sim.sh Connection Pool Simulator
# By Edward Stoever for MariaDB Support

### DO NOT EDIT SCRIPT. 
### FOR FULL INSTRUCTIONS: README.md
### FOR BRIEF INSTRUCTIONS: ./conn_pool_sim.sh --help


# Establish working directory and source vsn.sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ${SCRIPT_DIR}/vsn.sh

touch ${SCRIPT_DIR}/STOP_NOW && echo "Created stop file: ${SCRIPT_DIR}/STOP_NOW. Wait 10 seconds for Connection Pool Simulator to stop." || echo "Something unexpected occurred."

