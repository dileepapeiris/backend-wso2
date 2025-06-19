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

type ParticipantDatabaseConfig  record {|
    *DatabaseConfig;
    mysql:Options? options;
|};


# Participant creation payload
public type CreateParticipantPayload record {|
    string name;
    string nicNumber;
    string? email;
    
|};