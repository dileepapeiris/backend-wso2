import ballerina/sql;
# Query to add a new participant in the participant table.
#
# + participant - Object containing complete details of the participant.
# + createdBy - The user who created the participant.
# + return - sql:ParameterizedQuery 
isolated function addParticipantQuery(
    CreateParticipantPayload participant,
    string createdBy
) returns sql:ParameterizedQuery {
    return `INSERT INTO participant (
        name, 
        nic_number, 
        email, 
        created_by
    ) VALUES (
        ${participant.name},
        ${participant.nicNumber},
        ${participant.email},
        ${createdBy}
    )`;
}
# Query to get details about all participants in the participant table.
# + return - sql:ParameterizedQuery
# This query retrieves all participants.
isolated function getAllParticipantsQuery() returns sql:ParameterizedQuery {
    return `SELECT * FROM participant`;
}
# Query to get a participant by their name.
# + name - The name of the participant to search for.
# + return - sql:ParameterizedQuery
# This query retrieves a participant by their name.
isolated function getParticipantByNameQuery(string name) returns sql:ParameterizedQuery {
    return `SELECT * FROM participant WHERE name = ${name}`;
}
# Query to get a participant by their NIC number.
# + nicNumber - The NIC number of the participant to search for.
# + return - sql:ParameterizedQuery
# This query retrieves a participant by their NIC number.
isolated function getParticipantByNicNumberQuery(string nicNumber) returns sql:ParameterizedQuery {
    return `SELECT * FROM participant WHERE nic_number = ${nicNumber}`;
}
# Query to delete a participant's details.
# # + nicNumber - The NIC number of the participant to delete.
isolated function deleteParticipantByNicNumberQuery(string nicNumber) returns sql:ParameterizedQuery {
    return `DELETE FROM participant WHERE nic_number = ${nicNumber}`;
}
# Query to update a participant's details.
# # + participant - Object containing complete details of the participant.
# # + nicNumber - The NIC number of the participant to update.
isolated function updateParticipantByNicNumberQuery( CreateParticipantPayload participant , string nicNumber) returns sql:ParameterizedQuery {
    return `UPDATE participant
            SET name = ${participant.name},
                email = ${participant.email}
            WHERE nic_number = ${nicNumber}`;
}



