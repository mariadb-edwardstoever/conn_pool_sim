# Mariadb Connection Pool Simulator

### What is a connection pool?
To avoid connecting repeatedly or maintaining individual sessions for many users, applications use a connection pools.

The simplest way to think of a connection pool is 100 users connecting to an application and the application routing their requests through 10 pre-established connections to the database. This practice allows the application and database to handle more requests because the overhead of establishing new connections and maintaining idle connections is minimized.

### Connection Pool Simulator
The Mariadb Connection Pool Simulator is a bash script that uses the Mariadb command line client to create a connection pool and send sample queries to it. Possible uses:

 - Develop database software
 - Test database performance
 - Demonstrate to a live audience

### Setting up the Simulator
There are two steps to setting up the simulator:

 1. In the SQL directory, you will find some sample sql scripts. Replace the generic sql scripts with your scripts. You can use any script that can be run by the MariaDB client. Commands must be closed with a ";" or "\G". You can have multiple commands in a given script. There is no limit to the number of scripts you can place in the directory. Scripts are chosen to be run at random. You can use DML commands and SELECT commands. You can combine low-cost queries with high-cost queries. You can set the chances that a script is run by skewing the number of scripts that run one operation against the number of scripts that run another operation.
 
 2. Edit the file simulator.cnf and configure the connection.

### Examples of running the script on the command line

```
./conn_pool_sim.sh
./conn_pool_sim.sh --help
./conn_pool_sim.sh --minutes=100
./conn_pool_sim.sh --minutes=100 --qpm_low=100
./conn_pool_sim.sh --minutes=100 --qpm_low=100 --qpm_high=1000
./conn_pool_sim.sh --minutes=100 --qpm_low=100 --qpm_high=1000 --connections=40
./conn_pool_sim.sh --cleanup
```    
    
### Available Options

```
This script can be run without options. Not indicating an option value will use the default.
  --minutes=10         # Indicate the number of minutes to run connection pool, default 5.
  --connections=15     # Indicate the number of connections maintained, default 10.
  --qpm_low            # Low target of queries per minute, default 100.
  --qpm_high           # High target of queries per minute, default value is equal to
                       # qpm_low for a constant stream of queries with no variation.
  --cleanup            # If script is cancelled, processes must be killed and pipes removed.
                       # Use the cleanup option to start over.
  --test               # Test connect to database and display script version.
  --version            # Test connect to database and display script version.
  --help               # Display the help menu
```

### Queries Per Minute

The connection pool simulator will run whatever sql files (scripts) are placed in the SQL directory, chosen at random. Generic scripts that will run on any Mariadb database are provided. They should be replaced with your scripts. Files should written in text and end with ".sql".

"QPM" or queries per minute is the number of sql scripts sent to the connection pool per minute.

If you set a value for  `--qpm_low` and not a value for `--qpm_high`, the simulator will send a constant number of sql scripts per minute.

If you set a value for `--qpm_low` and also a value for `--qpm_high`, the simulator will vary the number of sql scripts sent per minute, from low to high. The variance will adjust at random every 10 seconds. 

### Stopping the script prematurely

You can quit a running connection pool at any time with ctrl+C. This will leave processes running that will require a clean-up. Run the script again with the cleanup option:
```
./conn_pool_sim --cleanup
```
For a graceful shutdown that does not require clean up, stop the running process from a separate command line with the stop_run.sh script:
```
./stop_run.sh
```

### Encountering errors in a SQL script

If a SQL script generates an error, the error message will be saved in the file `/tmp/conn_pool_sim/SQL_ERRORS`. When the simulator finishes a run, it will inform you if errors were generated.
