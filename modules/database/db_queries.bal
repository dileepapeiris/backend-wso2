import ballerina/sql;

# Query to add a new participant in the participant table.
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
