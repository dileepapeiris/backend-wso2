import ballerina/http;
import ballerina/log;
import backend_wso2.database as db;


//http service to handle participant-related operations
service http:InterceptableService / on new http:Listener(9090) {

    // post: Add a new participant
    resource function post addParticipant(http:RequestContext ctx, db:CreateParticipantPayload participant) returns AddParticipantResponse|http:InternalServerError|http:Conflict {
    int|error participantId = db:addParticipant(participant, "admin");

    if participantId is error {
        string errorMessage = participantId.message();

        
       if errorMessage.indexOf("already exists") >= 0 {

            return <http:Conflict>{
                body: {
                    message: errorMessage
                }
            };
        }

        log:printError("Failed to add participant", participantId);
        return <http:InternalServerError>{
            body: {
                message: "Failed to add participant"
            }
        };
    }

    return { participantId };
}

public function createInterceptors() returns http:Interceptor[] =>
        [ new ErrorInterceptor()];
}