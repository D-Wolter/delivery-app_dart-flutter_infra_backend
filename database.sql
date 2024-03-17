-- MySQL Script generated by MySQL Workbench
-- Sun Mar 17 17:13:08 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema delivery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema delivery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `delivery` DEFAULT CHARACTER SET utf8 ;
USE `delivery` ;

-- -----------------------------------------------------
-- Table `delivery`.`tb_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `data_birth` DATETIME NOT NULL,
  `docment` VARCHAR(14) NOT NULL,
  `email` VARCHAR(145) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `device_token` VARCHAR(255) NULL,
  `city` VARCHAR(45) NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT NOW(),
  `dtUpdated` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `documento_UNIQUE` (`docment` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `dt_criacao` DATETIME DEFAULT NOW(),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_usuario_permissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_usuario_permissao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `idPermission` INT NOT NULL,
  INDEX `fk_usuario_permissao_permissoes1_idx` (`idPermission` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_usuario_permissao_usuarios`
    FOREIGN KEY (`idUser`)
    REFERENCES `delivery`.`tb_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_permissao_permissoes1`
    FOREIGN KEY (`idPermission`)
    REFERENCES `delivery`.`tb_permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_establishment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_establishment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `phone` VARCHAR(11) NULL,
  `descrition` VARCHAR(155) NULL,
  `imageUrl` VARCHAR(255) NULL,
  `latitude` VARCHAR(15) NOT NULL,
  `longitude` VARCHAR(15) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `addressNumber` VARCHAR(6) NOT NULL,
  `addressDescription` VARCHAR(15) NULL,
  `status` VARCHAR(1) NULL,
  `dtCreated` DATETIME DEFAULT NOW(),
  `dtUpdated` DATETIME NULL,
  `idUser` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_estabelecimentos_tb_usuarios1_idx` (`idUser` ASC),
  CONSTRAINT `fk_tb_estabelecimentos_tb_usuarios1`
    FOREIGN KEY (`idUser`)
    REFERENCES `delivery`.`tb_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(115) NULL,
  `dtCreated` DATETIME DEFAULT NOW(),
  `dtUpdated` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `price` DOUBLE NOT NULL,
  `status` VARCHAR(1) NULL,
  `dtCreated` DATETIME DEFAULT NOW(),
  `dtUpdated` DATETIME NULL,
  `idCategorie` INT NOT NULL,
  `idEstablishment` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_products_tb_categories1_idx` (`idCategorie` ASC),
  INDEX `fk_tb_products_tb_establishment1_idx` (`idEstablishment` ASC),
  CONSTRAINT `fk_tb_products_tb_categories1`
    FOREIGN KEY (`idCategorie`)
    REFERENCES `delivery`.`tb_categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_products_tb_establishment1`
    FOREIGN KEY (`idEstablishment`)
    REFERENCES `delivery`.`tb_establishment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT NOW(),
  `dtUpdated` DATETIME NULL,
  `idUser` INT NOT NULL,
  `idProduct` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_sales_tb_users1_idx` (`idUser` ASC),
  INDEX `fk_tb_sales_tb_products1_idx` (`idProduct` ASC),
  CONSTRAINT `fk_tb_sales_tb_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `delivery`.`tb_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_sales_tb_products1`
    FOREIGN KEY (`idProduct`)
    REFERENCES `delivery`.`tb_products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_push`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery`.`tb_push` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tittle` VARCHAR(120) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `dtCreated` DATETIME DEFAULT NOW(),
  `idUser` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_push_tb_users1_idx` (`idUser` ASC),
  CONSTRAINT `fk_tb_push_tb_users1`
    FOREIGN KEY (`idUser`)
    REFERENCES `delivery`.`tb_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
