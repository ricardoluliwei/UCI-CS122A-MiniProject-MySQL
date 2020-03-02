CREATE SCHEMA `blurts`;

CREATE TABLE `blurts`.`user` (
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `data_of_birth` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`email`));

CREATE TABLE `blurts`.`celebrity` (
  `email` VARCHAR(45) NOT NULL,
  `website` VARCHAR(45) NULL,
  `kind` VARCHAR(45) NULL,
  PRIMARY KEY (`email`));
  
CREATE TABLE `blurts`.`blurt` (
  `blurtid` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `text` VARCHAR(100) NULL,
  `location` VARCHAR(45) NULL,
  `time` VARCHAR(45) NULL,
  PRIMARY KEY (`blurtid`,`email`),
  FOREIGN KEY (`email`) REFERENCES user(`email`));
  
CREATE TABLE `blurts`.`hobby` (
  `email` VARCHAR(45) NOT NULL,
  `hobby` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`email`,`hobby`),
  FOREIGN KEY (`email`) REFERENCES user(`email`));
  
CREATE TABLE `blurts`.`follow` (
  `follower` VARCHAR(45) NOT NULL,
  `followee` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`follower`,`followee`),
  FOREIGN KEY (`follower`) REFERENCES user(`email`),
  FOREIGN KEY (`followee`) REFERENCES user(`email`));
  
CREATE TABLE `blurts`.`vendor` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
CREATE TABLE `blurts`.`vendor_ambassador` (
  `vendorid` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  FOREIGN KEY (`email`) REFERENCES user(`email`),
  FOREIGN KEY (`vendorid`) REFERENCES vendor(`id`));
  
CREATE TABLE `blurts`.`topic` (
  `id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
CREATE TABLE `blurts`.`vendor_topics` (
  `vendorid` INT NOT NULL,
  `topicid` INT NOT NULL,
  PRIMARY KEY(`vendorid`,`topicid`),
  FOREIGN KEY(`vendorid`) REFERENCES vendor(`id`),
  FOREIGN KEY(`topicid`) REFERENCES topic(`id`));
  
CREATE TABLE `blurts`.`blurt_analysis` (
  `email` VARCHAR(45) NOT NULL,
  `blurtid` INT NOT NULL,
  `topicid` INT NOT NULL,
  `confidence` INT NULL,
  `sentiment` INT NULL,
  PRIMARY KEY(`email`,`blurtid`,`topicid`),
  FOREIGN KEY(`email`,`blurtid`) REFERENCES blurt(`email`,`blurtid`),
  FOREIGN KEY(`topicid`) REFERENCES topic(`id`));
  
CREATE TABLE `blurts`.`advertisement` (
  `id` INT NOT NULL,
  `content` VARCHAR(50)NULL,
  `vendorid` INT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`vendorid`) REFERENCES vendor(`id`));
  
CREATE TABLE `blurts`.`user_ad` (
  `email` VARCHAR(45) NOT NULL,
  `adid` INT NOT NULL,
  PRIMARY KEY(`email`,`adid`),
  FOREIGN KEY(`email`) REFERENCES user(`email`),
  FOREIGN KEY(`adid`) REFERENCES advertisement(`id`));
