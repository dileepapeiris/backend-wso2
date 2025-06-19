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

# Participant record type
public type Participant record {|
    @sql:Column {name: "participant_id"}
    int participantId;
    
    @sql:Column {name: "name"}
    string name;
    
    @sql:Column {name: "nic_number"}
    string nicNumber;
    
    @sql:Column {name: "email"}
    string? email;
    
    @sql:Column {name: "created_by"}
    string createdBy;
|};
