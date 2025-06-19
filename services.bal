import ballerina/http;
import ballerina/log;
import backend_wso2.database as db;


//http service to handle participant-related operations
service http:InterceptableService / on new http:Listener(9090) {

    // post: Add a new participant
    // This function adds a new participant to the database.
    
    resource function post addParticipant(http:RequestContext ctx, db:CreateParticipantPayload participant) 
    returns AddParticipantResponse|http:InternalServerError|http:Conflict {
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

    // get: Retrieve all participants
    // This function retrieves all participants from the database.
    // Returns an array of Participant records or an error if the retrieval fails.
    //
    resource function get getAll() returns db:Participant[]|http:InternalServerError { 
            db:Participant[]|error participatArray = db:getAllParticipants();

            if participatArray is error {
                string errorMessage = "Failed to retrieve participants";
                log:printError(errorMessage, participatArray);

                return <http:InternalServerError> {
                    body : {
                        "message" : errorMessage
                    }
                };
            }

            return participatArray;
        }

    // get: Retrieve a participant by their name
        resource function get getParticipantByName(http:RequestContext ctx, string name) 
        returns db:Participant|http:InternalServerError{
        db:Participant|error participant = db:getParticipantByName(name);

        if participant is error {
            string errorMessage = "Failed to retrieve participant with name: " + name;
            log:printError(errorMessage, participant);

            return <http:InternalServerError> {
                body : {
                    "message" : errorMessage
                }
            };
        }

        return participant;
    }



}


service class ErrorInterceptor {
    *http:ResponseErrorInterceptor;

    remote function interceptResponseError(error err, http:RequestContext ctx) returns http:BadRequest|error {

       
        if err is http:PayloadBindingError {
            string customError = string `Payload binding failed!`;
            log:printError(customError, err);
            return {
                body: {
                    message: customError
                }
            };
        }
        return err;
    }
}