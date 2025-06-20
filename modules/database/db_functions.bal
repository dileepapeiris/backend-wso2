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


# Get a participant by their name.
# # + name - The name of the participant to search for.
public isolated function getParticipantByName(string name) returns Participant|error {
   Participant|error participant = databaseClient->queryRow(getParticipantByNameQuery(name));
    if participant is error && participant is sql:NoRowsError {
        return error("Participant not found with name: " + name);
    }
    return participant;
   
}

# Get a participant by their NIC number.
# # + nicNumber - The NIC number of the participant to search for.
public isolated function getParticipantByNicNumber(string nicNumber) returns Participant|error {
   Participant|error participant = databaseClient->queryRow(getParticipantByNicNumberQuery(nicNumber));
    if participant is error && participant is sql:NoRowsError {
        return error("Participant not found with NIC Number: " + nicNumber);
    }
    return participant;
   
}

# Delete a participant's details.
# # + nicNumber - The NIC number of the participant to delete.
public isolated function deleteParticipantByNicNumber(string nicNumber) returns string|error {
    sql:ExecutionResult|error result = databaseClient->execute(deleteParticipantByNicNumberQuery(nicNumber));

    if result is error {
        return result;
    }

    if result.affectedRowCount == 0 {
        return error("No participant found with NIC Number: " + nicNumber);
    }

    return "Participant with NIC Number " + nicNumber + " deleted successfully.";
}


# Update a participant's details.
# # + participant - Object containing complete details of the participant
# # + nicNumber - The NIC number of the participant to update.
public isolated function updateParticipantByNicNumber(CreateParticipantPayload participant, string nicNumber) returns string|error {
    sql:ExecutionResult|error result = databaseClient->execute(updateParticipantByNicNumberQuery(participant, nicNumber));

    if result is error {
        return result;
    }

    if result.affectedRowCount == 0 {
        return error("No participant found with NIC Number: " + nicNumber);
    }

    return "Participant with NIC Number " + nicNumber + " updated successfully.";
}




