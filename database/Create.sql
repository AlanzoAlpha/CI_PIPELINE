
DROP DATABASE IF EXISTS testdb;
DROP DATABASE IF EXISTS users;

CREATE DATABASE testdb;
CREATE DATABASE users;
USE users;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userName` varchar(30) NOT NULL
);

INSERT INTO `users` VALUES ('Alanzo'),('Bob'),('Jay'),('Matt'),('Ferg'),('Mo');
