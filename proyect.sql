-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dim-cine
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dim-cine` ;

-- -----------------------------------------------------
-- Schema dim-cine
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dim-cine` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema transc-cine
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `transc-cine` ;

-- -----------------------------------------------------
-- Schema transc-cine
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `transc-cine` DEFAULT CHARACTER SET utf8 ;
USE `dim-cine` ;

-- -----------------------------------------------------
-- Table `dim-cine`.`Aforo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Aforo` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Aforo` (
  `idAforo` INT(11) NOT NULL,
  `asistentes` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAforo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Cine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Cine` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Cine` (
  `idCine` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCine`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Clasificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Clasificacion` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Clasificacion` (
  `idClasifacion` INT(11) NOT NULL,
  `Edad` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`idClasifacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Fecha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Fecha` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Fecha` (
  `idFecha` INT(11) NOT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `semana` INT(11) NULL DEFAULT NULL,
  `mes` INT(11) NULL DEFAULT NULL,
  `año` YEAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`idFecha`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Genero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Genero` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Genero` (
  `idGenero` INT(11) NOT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Peliculas` (
  `id` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `presupuesto` INT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Sala` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Sala` (
  `idSala` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idSala`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Promocion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Promocion` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Promocion` (
  `idPromocion` INT(11) NOT NULL,
  `Descuento` VARCHAR(45) NULL DEFAULT NULL,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idPromocion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dim-cine`.`Hechos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dim-cine`.`Hechos` ;

CREATE TABLE IF NOT EXISTS `dim-cine`.`Hechos` (
  `idHechos` INT(11) NOT NULL,
  `Fecha_idFecha` INT(11) NOT NULL,
  `Cine_idCine` INT(11) NOT NULL,
  `Peliculas_id` INT(11) NOT NULL,
  `Aforo_idAforo` INT(11) NOT NULL,
  `Clasificacion_idClasifacion` INT(11) NOT NULL,
  `Sala_idSala` INT(11) NOT NULL,
  `Promocion_idPromocion` INT(11) NOT NULL,
  `Genero_idGenero` INT(11) NOT NULL,
  PRIMARY KEY (`idHechos`),
  CONSTRAINT `fk_Hechos_Fecha`
    FOREIGN KEY (`Fecha_idFecha`)
    REFERENCES `dim-cine`.`Fecha` (`idFecha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hechos_Cine1`
    FOREIGN KEY (`Cine_idCine`)
    REFERENCES `dim-cine`.`Cine` (`idCine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hechos_Peliculas1`
    FOREIGN KEY (`Peliculas_id`)
    REFERENCES `dim-cine`.`Peliculas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hechos_Aforo1`
    FOREIGN KEY (`Aforo_idAforo`)
    REFERENCES `dim-cine`.`Aforo` (`idAforo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hechos_Clasificacion1`
    FOREIGN KEY (`Clasificacion_idClasifacion`)
    REFERENCES `dim-cine`.`Clasificacion` (`idClasifacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hechos_Sala1`
    FOREIGN KEY (`Sala_idSala`)
    REFERENCES `dim-cine`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hechos_Promocion1`
    FOREIGN KEY (`Promocion_idPromocion`)
    REFERENCES `dim-cine`.`Promocion` (`idPromocion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hechos_Genero1`
    FOREIGN KEY (`Genero_idGenero`)
    REFERENCES `dim-cine`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Hechos_Fecha_idx` ON `dim-cine`.`Hechos` (`Fecha_idFecha` ASC);

CREATE INDEX `fk_Hechos_Cine1_idx` ON `dim-cine`.`Hechos` (`Cine_idCine` ASC);

CREATE INDEX `fk_Hechos_Peliculas1_idx` ON `dim-cine`.`Hechos` (`Peliculas_id` ASC);

CREATE INDEX `fk_Hechos_Aforo1_idx` ON `dim-cine`.`Hechos` (`Aforo_idAforo` ASC);

CREATE INDEX `fk_Hechos_Clasificacion1_idx` ON `dim-cine`.`Hechos` (`Clasificacion_idClasifacion` ASC);

CREATE INDEX `fk_Hechos_Sala1_idx` ON `dim-cine`.`Hechos` (`Sala_idSala` ASC);

CREATE INDEX `fk_Hechos_Promocion1_idx` ON `dim-cine`.`Hechos` (`Promocion_idPromocion` ASC);

CREATE INDEX `fk_Hechos_Genero1_idx` ON `dim-cine`.`Hechos` (`Genero_idGenero` ASC);

USE `transc-cine` ;

-- -----------------------------------------------------
-- Table `transc-cine`.`Cine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Cine` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Cine` (
  `idCine` INT(11) NOT NULL,
  `Nombre` VARCHAR(60) NULL DEFAULT NULL,
  `direccion` VARCHAR(120) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idCine`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transc-cine`.`Pelicula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Pelicula` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Pelicula` (
  `id` INT(11) NOT NULL,
  `titulo_distribuido` VARCHAR(200) NULL DEFAULT NULL,
  `titulo_original` VARCHAR(200) NULL DEFAULT NULL,
  `idioma_original` VARCHAR(45) NULL DEFAULT NULL,
  `resumen` VARCHAR(45) NULL DEFAULT NULL,
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
-- Table `transc-cine`.`Sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Sala` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Sala` (
  `id` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `aforo` INT(11) NULL DEFAULT NULL,
  `Cine_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Sala_Cine1`
    FOREIGN KEY (`Cine_id`)
    REFERENCES `transc-cine`.`Cine` (`idCine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Sala_Cine1_idx` ON `transc-cine`.`Sala` (`Cine_id` ASC);


-- -----------------------------------------------------
-- Table `transc-cine`.`Funcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Funcion` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Funcion` (
  `Pelicula_id` INT(11) NOT NULL,
  `Sala_id` INT(11) NOT NULL,
  `dia` DATE NULL DEFAULT NULL,
  `hora` TIME NULL DEFAULT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Funcion_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transc-cine`.`Pelicula` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcion_Sala1`
    FOREIGN KEY (`Sala_id`)
    REFERENCES `transc-cine`.`Sala` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Funcion_Pelicula1_idx` ON `transc-cine`.`Funcion` (`Pelicula_id` ASC);

CREATE INDEX `fk_Funcion_Sala1_idx` ON `transc-cine`.`Funcion` (`Sala_id` ASC);


-- -----------------------------------------------------
-- Table `transc-cine`.`Genero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Genero` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Genero` (
  `idGenero` INT(11) NOT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transc-cine`.`Genero_Pelicula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Genero_Pelicula` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Genero_Pelicula` (
  `Genero_idGenero` INT(11) NOT NULL,
  `Pelicula_id` INT(11) NOT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Genero_has_Pelicula_Genero1`
    FOREIGN KEY (`Genero_idGenero`)
    REFERENCES `transc-cine`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Genero_has_Pelicula_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transc-cine`.`Pelicula` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Genero_has_Pelicula_Pelicula1_idx` ON `transc-cine`.`Genero_Pelicula` (`Pelicula_id` ASC);

CREATE INDEX `fk_Genero_has_Pelicula_Genero1_idx` ON `transc-cine`.`Genero_Pelicula` (`Genero_idGenero` ASC);


-- -----------------------------------------------------
-- Table `transc-cine`.`Opinion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Opinion` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Opinion` (
  `id` INT(11) NOT NULL,
  `nombre_persona` VARCHAR(60) NULL DEFAULT NULL,
  `edad` INT(11) NULL DEFAULT NULL,
  `calificacion` INT(11) NULL DEFAULT NULL,
  `comentario` TEXT NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `Pelicula_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Opinion_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transc-cine`.`Pelicula` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Opinion_Pelicula1_idx` ON `transc-cine`.`Opinion` (`Pelicula_id` ASC);


-- -----------------------------------------------------
-- Table `transc-cine`.`Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Pais` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Pais` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transc-cine`.`Pelicula_Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Pelicula_Pais` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Pelicula_Pais` (
  `Pelicula_id` INT(11) NOT NULL,
  `Pais_id` INT(11) NOT NULL,
  CONSTRAINT `fk_Pelicula_has_Pais_Pais1`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `transc-cine`.`Pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pelicula_has_Pais_Pelicula`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transc-cine`.`Pelicula` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Pelicula_has_Pais_Pais1_idx` ON `transc-cine`.`Pelicula_Pais` (`Pais_id` ASC);

CREATE INDEX `fk_Pelicula_has_Pais_Pelicula_idx` ON `transc-cine`.`Pelicula_Pais` (`Pelicula_id` ASC);


-- -----------------------------------------------------
-- Table `transc-cine`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Roles` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Roles` (
  `id` INT(11) NOT NULL,
  `tipo` VARCHAR(100) NULL DEFAULT NULL,
  `salario` INT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `transc-cine`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Persona` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Persona` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(60) NULL DEFAULT NULL,
  `Pais_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Persona_Pais1`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `transc-cine`.`Pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Persona_Pais1_idx` ON `transc-cine`.`Persona` (`Pais_id` ASC);


-- -----------------------------------------------------
-- Table `transc-cine`.`Pelicula_Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`Pelicula_Persona` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`Pelicula_Persona` (
  `Pelicula_id` INT(11) NOT NULL,
  `Persona_id` INT(11) NOT NULL,
  `Roles_id` INT(11) NOT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Pelicula_Persona_Roles1`
    FOREIGN KEY (`Roles_id`)
    REFERENCES `transc-cine`.`Roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pelicula_has_Persona_Pelicula1`
    FOREIGN KEY (`Pelicula_id`)
    REFERENCES `transc-cine`.`Pelicula` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pelicula_has_Persona_Persona1`
    FOREIGN KEY (`Persona_id`)
    REFERENCES `transc-cine`.`Persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Pelicula_has_Persona_Persona1_idx` ON `transc-cine`.`Pelicula_Persona` (`Persona_id` ASC);

CREATE INDEX `fk_Pelicula_has_Persona_Pelicula1_idx` ON `transc-cine`.`Pelicula_Persona` (`Pelicula_id` ASC);

CREATE INDEX `fk_Pelicula_Persona_Roles1_idx` ON `transc-cine`.`Pelicula_Persona` (`Roles_id` ASC);


-- -----------------------------------------------------
-- Table `transc-cine`.`promocion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transc-cine`.`promocion` ;

CREATE TABLE IF NOT EXISTS `transc-cine`.`promocion` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `Funcion_id` INT(11) NOT NULL,
  `descuento` FLOAT(4,4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_promocion_Funcion1`
    FOREIGN KEY (`Funcion_id`)
    REFERENCES `transc-cine`.`Funcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_promocion_Funcion1_idx` ON `transc-cine`.`promocion` (`Funcion_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
