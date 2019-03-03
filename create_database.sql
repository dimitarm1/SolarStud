-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema solar_power
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema solar_power
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `solar_power` DEFAULT CHARACTER SET utf8 ;
USE `solar_power` ;

-- -----------------------------------------------------
-- Table `solar_power`.`timestamps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solar_power`.`timestamps` ;

CREATE TABLE IF NOT EXISTS `solar_power`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


-- -----------------------------------------------------
-- Table `solar_power`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solar_power`.`user` ;

CREATE TABLE IF NOT EXISTS `solar_power`.`user` (
  `XKEY` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `admin` TINYINT NULL DEFAULT 0,
  `pechene` TINYINT NULL DEFAULT 1,
  `uslugi` TINYINT NULL DEFAULT 1,
  `stoki` TINYINT NULL DEFAULT 1,
  `dostavki` TINYINT NULL,
  `izdava_karti` TINYINT NULL DEFAULT 1,
  `protokol` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`XKEY`));


-- -----------------------------------------------------
-- Table `solar_power`.`solariumi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solar_power`.`solariumi` ;

CREATE TABLE IF NOT EXISTS `solar_power`.`solariumi` (
  `XKEY` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `IME` VARCHAR(45) NULL DEFAULT 'SOLARIUM',
  `IP_ADRES` VARCHAR(15) NULL DEFAULT NULL,
  `com_port` VARCHAR(15) NULL DEFAULT NULL,
  `kartinka` BLOB NULL DEFAULT NULL,
  `CENA_BROI` FLOAT(12,2) NULL DEFAULT 0,
  `AKTIVEN` TINYINT NULL DEFAULT 1,
  `ID` INT(11) NULL,
  PRIMARY KEY (`XKEY`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solar_power`.`karti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solar_power`.`karti` ;

CREATE TABLE IF NOT EXISTS `solar_power`.`karti` (
  `XKEY` INT(11) NOT NULL AUTO_INCREMENT,
  `IME` VARCHAR(45) NULL DEFAULT '',
  `CENA` FLOAT(12,2) NULL DEFAULT 0,
  `AKTIVNA` TINYINT NULL DEFAULT 1,
  `ID` INT(11) NULL,
  PRIMARY KEY (`XKEY`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solar_power`.`prodajbi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solar_power`.`prodajbi` ;

CREATE TABLE IF NOT EXISTS `solar_power`.`prodajbi` (
  `XKEY` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TIMESTAMP` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `STOKA_KOD` INT(11) NULL,
  `SOLARIUM_XID` INT(11) NULL,
  `KOLICHESTVO` FLOAT(12,2) NOT NULL,
  `EDINICHNA_CENA` FLOAT(12,2) NULL,
  `OTSTAPKA` FLOAT(12,2) NULL,
  `PLATENO_V_BROI` TINYINT NULL,
  `KARTA_NOMER` INT(11) NULL,
  `KRAINA_CENA` FLOAT(12,2) NULL,
  PRIMARY KEY (`XKEY`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solar_power`.`pechenia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solar_power`.`pechenia` ;

CREATE TABLE IF NOT EXISTS `solar_power`.`pechenia` (
  `XKEY` INT(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `SOLARIUM_XID` INT(11) NULL,
  `MINUTI` TINYINT NULL,
  `pecheniacol` VARCHAR(45) NULL,
  PRIMARY KEY (`XKEY`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
