import ballerinax/mysql;
import ballerinax/mysql.driver as _;
configurable DatabaseConfig databaseConfig = ?;

ParticipantDatabaseConfig ParticipantDb = {
    ...databaseConfig,
    options: {
        ssl: {
            mode: mysql:SSL_REQUIRED
        },
        connectTimeout: 10
    }
};

public final mysql:Client databaseClient = check new (...ParticipantDb);