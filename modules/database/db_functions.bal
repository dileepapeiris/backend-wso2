import ballerina/sql;



# Inserts participants personal details.
# 
# + participant - Object containing complete details of the participant 
# + createdBy - The user who created the participant
public isolated function addParticipant(CreateParticipantPayload participant, string createdBy) returns int|error {
    sql:ExecutionResult|error result = databaseClient->execute(addParticipantQuery(participant, createdBy));

    if result is error {
        
        if result is sql:DatabaseError && result.detail()?.errorCode is int && result.detail().errorCode == 1062 {
            return error("Participant with NIC Number '" + participant.nicNumber + "' already exists.");
        }
        return result;
    }

    return result.lastInsertId.ensureType();
}

#Get participants personal details.
# # This function retrieves all participants from the database.
# + participant - Object containing complete details of the participant 
# 
public isolated function getAllParticipants() returns Participant[]|error {
    stream<Participant, sql:Error?> resultStream = 
        databaseClient->query(getAllParticipantsQuery());

   
    Participant[] participants = [];

    check from Participant p in resultStream
        do {
            participants.push(p);
        };

    return participants;
}

