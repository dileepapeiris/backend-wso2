CREATE TABLE `participant` (
  `participant_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `nic_number` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_by` varchar(60) NOT NULL,
  UNIQUE KEY `unique_nic` (`nic_number`),
  PRIMARY KEY (`participant_id`)
);

