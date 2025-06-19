import ballerina/sql;
import ballerinax/mysql;

# Database configuration
type DatabaseConfig record {|
    string user;
    string password;
    string database;
    string host;
    int port;
|};