CREATE DATABASE IF NOT EXISTS card CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON card.* to 'user'@'%' IDENTIFIED BY '123456';