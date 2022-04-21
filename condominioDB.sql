-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Administradora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Administradora` (
  `CNPJ` VARCHAR(18) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Gênero` CHAR(1) NOT NULL,
  `Data_Nascimento` DATETIME NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  `Profissão` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Apartamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Apartamento` (
  `Cod_Apartamento` INT NOT NULL,
  `Cod_Edifício` VARCHAR(9) NOT NULL,
  `CPF_Proprietário` VARCHAR(14) NULL,
  `NúmeroApt` INT NULL,
  `Qtd_Quartos` INT NULL,
  `Qtd_Banheiros` INT NULL,
  `Edifício_Cod_Edifício` VARCHAR(9) NOT NULL,
  `Pessoa_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Cod_Apartamento`, `Edifício_Cod_Edifício`),
  INDEX `fk_Apartamento_Edifício1_idx` (`Edifício_Cod_Edifício` ASC) VISIBLE,
  INDEX `fk_Apartamento_Pessoa1_idx` (`Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Apartamento_Edifício1`
    FOREIGN KEY (`Edifício_Cod_Edifício`)
    REFERENCES `mydb`.`Edifício` (`Cod_Edifício`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Apartamento_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `mydb`.`Pessoa` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Morador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Morador` (
  `Cod_Apartamento` INT NOT NULL,
  `Cod_Edifício` VARCHAR(9) NOT NULL,
  `CPF_Morador` VARCHAR(14) NOT NULL,
  `Apartamento_Cod_Apartamento` INT NOT NULL,
  `Edifício_Cod_Edifício` VARCHAR(9) NOT NULL,
  `Pessoa_CPF` VARCHAR(14) NOT NULL,
  INDEX `fk_Morador_Apartamento1_idx` (`Apartamento_Cod_Apartamento` ASC) VISIBLE,
  INDEX `fk_Morador_Edifício1_idx` (`Edifício_Cod_Edifício` ASC) VISIBLE,
  PRIMARY KEY (`Pessoa_CPF`),
  CONSTRAINT `fk_Morador_Apartamento1`
    FOREIGN KEY (`Apartamento_Cod_Apartamento`)
    REFERENCES `mydb`.`Apartamento` (`Cod_Apartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Morador_Edifício1`
    FOREIGN KEY (`Edifício_Cod_Edifício`)
    REFERENCES `mydb`.`Edifício` (`Cod_Edifício`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Morador_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `mydb`.`Pessoa` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Edifício`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Edifício` (
  `Cod_Edifício` VARCHAR(9) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `CPF_Síndico` VARCHAR(14) NOT NULL,
  `CNPJ_Admin` VARCHAR(18) NOT NULL,
  `Administradora_CNPJ` VARCHAR(18) NOT NULL,
  `Morador_Pessoa_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Cod_Edifício`),
  INDEX `fk_Edifício_Administradora_idx` (`Administradora_CNPJ` ASC) VISIBLE,
  INDEX `fk_Edifício_Morador1_idx` (`Morador_Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Edifício_Administradora`
    FOREIGN KEY (`Administradora_CNPJ`)
    REFERENCES `mydb`.`Administradora` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Edifício_Morador1`
    FOREIGN KEY (`Morador_Pessoa_CPF`)
    REFERENCES `mydb`.`Morador` (`Pessoa_CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionário` (
  `CPF_Funcionário` INT NOT NULL,
  `Cod_Edifício` VARCHAR(9) NOT NULL,
  `Data_Admissão` DATETIME NOT NULL,
  `CargoFunção` VARCHAR(45) NOT NULL,
  `Salário` INT NOT NULL,
  `Pessoa_CPF` VARCHAR(14) NOT NULL,
  `Edifício_Cod_Edifício` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`Pessoa_CPF`, `Edifício_Cod_Edifício`),
  INDEX `fk_Funcionário_Edifício1_idx` (`Edifício_Cod_Edifício` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionário_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `mydb`.`Pessoa` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionário_Edifício1`
    FOREIGN KEY (`Edifício_Cod_Edifício`)
    REFERENCES `mydb`.`Edifício` (`Cod_Edifício`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
