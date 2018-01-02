-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dimcine
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dimcine` ;

-- -----------------------------------------------------
-- Schema dimcine
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dimcine` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema transccine
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `transccine` ;

-- -----------------------------------------------------
-- Schema transccine
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `transccine` DEFAULT CHARACTER SET utf8 ;
USE `dimcine` ;

-- -----------------------------------------------------
-- Table `dimcine`.`Aforo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Aforo` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Aforo` (
  `id` INT(11) NOT NULL,
  `asistentes` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Cine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Cine` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Cine` (
  `id` INT(11) NOT NULL,
  `Nombre` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Clasificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Clasificacion` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Clasificacion` (
  `id` INT(11) NOT NULL,
  `rango` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Fecha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Fecha` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Fecha` (
  `id` INT(11) NOT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `semana` INT(2) NULL DEFAULT NULL,
  `mes` INT(2) NULL DEFAULT NULL,
  `año` YEAR(4) NULL DEFAULT NULL,
  `trimestre` INT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Genero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Genero` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Genero` (
  `id` INT(11) NOT NULL,
  `tipo` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Peliculas` (
  `id` INT(11) NOT NULL,
  `Nombre` VARCHAR(200) NULL DEFAULT NULL,
  `presupuesto` INT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Promocion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Promocion` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Promocion` (
  `id` INT(11) NOT NULL,
  `Descuento` FLOAT(4,4) NULL DEFAULT NULL,
  `Descripcion` TEXT(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Sala` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Sala` (
  `id` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dimcine`.`Hechos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dimcine`.`Hechos` ;

CREATE TABLE IF NOT EXISTS `dimcine`.`Hechos` (
  `id` INT(11) NOT NULL,
  `Peliculas_id` INT(11) NOT NULL,
  `Promocion_id` INT(11) NOT NULL,
  `Fecha_id` INT(11) NOT NULL,
  `Sala_id` INT(11) NOT NULL,
  `Clasificacion_id` INT(11) NOT NULL,
  `Cine_id` INT(11) NOT NULL,
  `Genero_id` INT(11) NOT NULL,
  `Aforo_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Hechos_Peliculas`
    FOREIGN KEY (`Peliculas_id`)
    REFERENCES `dimcine`.`Peliculas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hechos_Promocion1`
    FOREIGN KEY (`Promocion_id`)
    REFERENCES `dimcine`.`Promocion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hechos_Fecha1`
    FOREIGN KEY (`Fecha_id`)
    REFERENCES `dimcine`.`Fecha` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hechos_Sala1`
    FOREIGN KEY (`Sala_id`)
    REFERENCES `dimcine`.`Sala` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hechos_Clasificacion1`
    FOREIGN KEY (`Clasificacion_id`)
    REFERENCES `dimcine`.`Clasificacion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hechos_Cine1`
    FOREIGN KEY (`Cine_id`)
    REFERENCES `dimcine`.`Cine` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hechos_Genero1`
    FOREIGN KEY (`Genero_id`)
    REFERENCES `dimcine`.`Genero` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Hechos_Aforo1`
    FOREIGN KEY (`Aforo_id`)
    REFERENCES `dimcine`.`Aforo` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Hechos_Peliculas_idx` ON `dimcine`.`Hechos` (`Peliculas_id` ASC);

CREATE INDEX `fk_Hechos_Promocion1_idx` ON `dimcine`.`Hechos` (`Promocion_id` ASC);

CREATE INDEX `fk_Hechos_Fecha1_idx` ON `dimcine`.`Hechos` (`Fecha_id` ASC);

CREATE INDEX `fk_Hechos_Sala1_idx` ON `dimcine`.`Hechos` (`Sala_id` ASC);

CREATE INDEX `fk_Hechos_Clasificacion1_idx` ON `dimcine`.`Hechos` (`Clasificacion_id` ASC);

CREATE INDEX `fk_Hechos_Cine1_idx` ON `dimcine`.`Hechos` (`Cine_id` ASC);

CREATE INDEX `fk_Hechos_Genero1_idx` ON `dimcine`.`Hechos` (`Genero_id` ASC);

CREATE INDEX `fk_Hechos_Aforo1_idx` ON `dimcine`.`Hechos` (`Aforo_id` ASC);

USE `transccine` ;

-- -----------------------------------------------------
-- Table `transccine`.`Cine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Cine` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Cine` (
  `id` INT(11) NOT NULL,
  `Nombre` VARCHAR(60) NULL DEFAULT NULL,
  `direccion` VARCHAR(120) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transccine`.`Pelicula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Pelicula` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Pelicula` (
  `id` INT(11) NOT NULL,
  `titulo_distribuido` VARCHAR(200) NULL DEFAULT NULL,
  `titulo_original` VARCHAR(200) NULL DEFAULT NULL,
  `idioma_original` VARCHAR(45) NULL DEFAULT NULL,
  `resumen` TEXT(500) NULL DEFAULT NULL,
  `clasificacion` VARCHAR(45) NULL DEFAULT NULL,
  `subtitulos` TINYINT(1) NULL DEFAULT NULL,
  `duracion` INT(11) NULL DEFAULT NULL,
  `url` VARCHAR(500) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `produccion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transccine`.`Sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Sala` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Sala` (
  `id` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `aforo` INT(11) NULL DEFAULT NULL,
  `Cine_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Sala_Cine1`
    FOREIGN KEY (`Cine_id`)
    REFERENCES `transccine`.`Cine` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Sala_Cine1_idx` ON `transccine`.`Sala` (`Cine_id` ASC);


-- -----------------------------------------------------
-- Table `transccine`.`Funcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Funcion` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Funcion` (
  `id` INT(11) NOT NULL,
  `dia` DATE NULL DEFAULT NULL,
  `hora` TIME NULL DEFAULT NULL,
  `Pelicula_id` INT(11) NOT NULL,
  `Sala_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Funcion_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transccine`.`Pelicula` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Funcion_Sala1`
    FOREIGN KEY (`Sala_id`)
    REFERENCES `transccine`.`Sala` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Funcion_Pelicula1_idx` ON `transccine`.`Funcion` (`Pelicula_id` ASC);

CREATE INDEX `fk_Funcion_Sala1_idx` ON `transccine`.`Funcion` (`Sala_id` ASC);


-- -----------------------------------------------------
-- Table `transccine`.`Genero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Genero` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Genero` (
  `id` INT(11) NOT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transccine`.`Genero_Pelicula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Genero_Pelicula` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Genero_Pelicula` (
  `id` INT(11) NOT NULL,
  `Genero_id` INT(11) NOT NULL,
  `Pelicula_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Genero_has_Pelicula_Genero1`
    FOREIGN KEY (`Genero_id`)
    REFERENCES `transccine`.`Genero` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Genero_has_Pelicula_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transccine`.`Pelicula` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Genero_has_Pelicula_Pelicula1_idx` ON `transccine`.`Genero_Pelicula` (`Pelicula_id` ASC);

CREATE INDEX `fk_Genero_has_Pelicula_Genero1_idx` ON `transccine`.`Genero_Pelicula` (`Genero_id` ASC);


-- -----------------------------------------------------
-- Table `transccine`.`Opinion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Opinion` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Opinion` (
  `id` INT(11) NOT NULL,
  `nombre_persona` VARCHAR(60) NULL DEFAULT NULL,
  `edad` INT(11) NULL DEFAULT NULL,
  `calificacion` INT(11) NULL DEFAULT NULL,
  `comentario` TEXT(1500) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `Pelicula_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Opinion_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transccine`.`Pelicula` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Opinion_Pelicula1_idx` ON `transccine`.`Opinion` (`Pelicula_id` ASC);


-- -----------------------------------------------------
-- Table `transccine`.`Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Pais` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Pais` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transccine`.`Pelicula_Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Pelicula_Pais` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Pelicula_Pais` (
  `id` VARCHAR(45) NOT NULL,
  `Pelicula_id` INT(11) NOT NULL,
  `Pais_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Pelicula_has_Pais_Pais1`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `transccine`.`Pais` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pelicula_has_Pais_Pelicula`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transccine`.`Pelicula` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Pelicula_has_Pais_Pais1_idx` ON `transccine`.`Pelicula_Pais` (`Pais_id` ASC);

CREATE INDEX `fk_Pelicula_has_Pais_Pelicula_idx` ON `transccine`.`Pelicula_Pais` (`Pelicula_id` ASC);


-- -----------------------------------------------------
-- Table `transccine`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Roles` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Roles` (
  `id` INT(11) NOT NULL,
  `tipo` VARCHAR(100) NULL DEFAULT NULL,
  `salario` INT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transccine`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Persona` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Persona` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(60) NULL DEFAULT NULL,
  `Pais_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Persona_Pais1`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `transccine`.`Pais` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Persona_Pais1_idx` ON `transccine`.`Persona` (`Pais_id` ASC);


-- -----------------------------------------------------
-- Table `transccine`.`Pelicula_Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`Pelicula_Persona` ;

CREATE TABLE IF NOT EXISTS `transccine`.`Pelicula_Persona` (
  `id` INT(11) NOT NULL,
  `Pelicula_id` INT(11) NOT NULL,
  `Persona_id` INT(11) NOT NULL,
  `Roles_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Pelicula_Persona_Roles1`
    FOREIGN KEY (`Roles_id`)
    REFERENCES `transccine`.`Roles` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pelicula_has_Persona_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transccine`.`Pelicula` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pelicula_has_Persona_Persona1`
    FOREIGN KEY (`Persona_id`)
    REFERENCES `transccine`.`Persona` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Pelicula_has_Persona_Persona1_idx` ON `transccine`.`Pelicula_Persona` (`Persona_id` ASC);

CREATE INDEX `fk_Pelicula_has_Persona_Pelicula1_idx` ON `transccine`.`Pelicula_Persona` (`Pelicula_id` ASC);

CREATE INDEX `fk_Pelicula_Persona_Roles1_idx` ON `transccine`.`Pelicula_Persona` (`Roles_id` ASC);


-- -----------------------------------------------------
-- Table `transccine`.`promocion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transccine`.`promocion` ;

CREATE TABLE IF NOT EXISTS `transccine`.`promocion` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` TEXT(200) NULL DEFAULT NULL,
  `descuento` FLOAT(4,4) NULL DEFAULT NULL,
  `Funcion_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_promocion_Funcion1`
    FOREIGN KEY (`Funcion_id`)
    REFERENCES `transccine`.`Funcion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_promocion_Funcion1_idx` ON `transccine`.`promocion` (`Funcion_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
