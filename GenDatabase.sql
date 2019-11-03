-- MySQL Script generated by MySQL Workbench
-- Sat Nov  2 23:59:54 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MeGusta
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `MeGusta` ;

-- -----------------------------------------------------
-- Schema MeGusta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MeGusta` ;
USE `MeGusta` ;

-- -----------------------------------------------------
-- Table `MeGusta`.`Zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Zona` (
  `nombre` VARCHAR(50) NOT NULL,
  `tamaño` VARCHAR(45) NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Sensor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Sensor` (
  `id` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `Zona_nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sensor_Zona1_idx` (`Zona_nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Sensor_Zona1`
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `MeGusta`.`Zona` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Medicion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Medicion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME(4) NULL,
  `valor` VARCHAR(45) NULL,
  `Zona_nombre` VARCHAR(50) NOT NULL,
  `Sensor_id` VARCHAR(45) NOT NULL,
  INDEX `fk_Medicion_Zona1_idx` (`Zona_nombre` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_Medicion_Sensor1_idx` (`Sensor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Medicion_Zona1`
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `MeGusta`.`Zona` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medicion_Sensor1`
    FOREIGN KEY (`Sensor_id`)
    REFERENCES `MeGusta`.`Sensor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Riego`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Riego` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME(4) NULL,
  `duracion` INT NULL,
  `Zona_nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Riego_Zona1_idx` (`Zona_nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Riego_Zona1`
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `MeGusta`.`Zona` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Especie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Especie` (
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `familia` VARCHAR(45) NULL,
  `tipoZona` VARCHAR(45) NULL,
  `tiempoCultivo` INT NULL,
  `tipoLuna` VARCHAR(45) NULL,
  `humedad` DOUBLE NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Semilla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Semilla` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Especie_nombre` VARCHAR(45) NOT NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Semilla_Especie1_idx` (`Especie_nombre` ASC) VISIBLE,
  INDEX `fk_Semilla_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Semilla_Especie1`
    FOREIGN KEY (`Especie_nombre`)
    REFERENCES `MeGusta`.`Especie` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Semilla_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `MeGusta`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Maceta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Maceta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `material` VARCHAR(45) NULL,
  `tamaño` VARCHAR(45) NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Maceta_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maceta_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `MeGusta`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Plantacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Plantacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Semilla_id` INT NOT NULL,
  `Maceta_id` INT NOT NULL,
  `cantidad` INT NULL,
  `fecha` DATETIME(4) NULL,
  PRIMARY KEY (`id`, `Semilla_id`, `Maceta_id`),
  INDEX `fk_Semilla_has_Maceta_Maceta1_idx` (`Maceta_id` ASC) VISIBLE,
  INDEX `fk_Semilla_has_Maceta_Semilla1_idx` (`Semilla_id` ASC) VISIBLE,
  CONSTRAINT `fk_Semilla_has_Maceta_Semilla1`
    FOREIGN KEY (`Semilla_id`)
    REFERENCES `MeGusta`.`Semilla` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Semilla_has_Maceta_Maceta1`
    FOREIGN KEY (`Maceta_id`)
    REFERENCES `MeGusta`.`Maceta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Planta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Planta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `precio` DOUBLE NULL,
  `Zona_nombre` VARCHAR(50) NOT NULL,
  `Especie_nombre` VARCHAR(45) NOT NULL,
  `Plantacion_id` INT NOT NULL,
  `Plantacion_Semilla_id` INT NOT NULL,
  `Plantacion_Maceta_id` INT NOT NULL,
  `Maceta_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Planta_Zona1_idx` (`Zona_nombre` ASC) VISIBLE,
  INDEX `fk_Planta_Especie1_idx` (`Especie_nombre` ASC) VISIBLE,
  INDEX `fk_Planta_Plantacion1_idx` (`Plantacion_id` ASC, `Plantacion_Semilla_id` ASC, `Plantacion_Maceta_id` ASC) VISIBLE,
  INDEX `fk_Planta_Maceta1_idx` (`Maceta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Planta_Zona1`
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `MeGusta`.`Zona` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Planta_Especie1`
    FOREIGN KEY (`Especie_nombre`)
    REFERENCES `MeGusta`.`Especie` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Planta_Plantacion1`
    FOREIGN KEY (`Plantacion_id` , `Plantacion_Semilla_id` , `Plantacion_Maceta_id`)
    REFERENCES `MeGusta`.`Plantacion` (`id` , `Semilla_id` , `Maceta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Planta_Maceta1`
    FOREIGN KEY (`Maceta_id`)
    REFERENCES `MeGusta`.`Maceta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Herramienta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Herramienta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NULL,
  `Zona_nombre` VARCHAR(50) NOT NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Herramienta_Zona1_idx` (`Zona_nombre` ASC) VISIBLE,
  INDEX `fk_Herramienta_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Herramienta_Zona1`
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `MeGusta`.`Zona` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Herramienta_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `MeGusta`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Lote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Lote` (
  `numero` INT NOT NULL,
  `fechaVencimiento` DATETIME(4) NULL,
  `restante` DOUBLE NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Lote_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Lote_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `MeGusta`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Aditivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Aditivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Aditivo_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Aditivo_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `MeGusta`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Empleado` (
  `ci` INT(8) NOT NULL,
  `usuario` VARCHAR(45) NULL,
  `contraseña` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `direccion` VARCHAR(60) NULL,
  `fechaNacimiento` DATETIME(4) NULL,
  `cargo` VARCHAR(45) NULL,
  PRIMARY KEY (`ci`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Proveedor` (
  `nombre` VARCHAR(45) NOT NULL,
  `RUT` VARCHAR(12) NULL,
  `direccion` VARCHAR(60) NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Empleado_ci` INT(8) NOT NULL,
  `fecha` DATETIME(4) NULL,
  `fechaEntrega` DATETIME(4) NULL,
  INDEX `fk_Pedido_Empleado1_idx` (`Empleado_ci` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Pedido_Empleado1`
    FOREIGN KEY (`Empleado_ci`)
    REFERENCES `MeGusta`.`Empleado` (`ci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Pedido_has_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Pedido_has_Producto` (
  `Pedido_id` INT NOT NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`Pedido_id`, `Producto_id`),
  INDEX `fk_Pedido_has_Producto_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Producto_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Producto_Pedido1`
    FOREIGN KEY (`Pedido_id`)
    REFERENCES `MeGusta`.`Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Producto_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `MeGusta`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Especie_has_Aditivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Especie_has_Aditivo` (
  `Especie_nombre` VARCHAR(45) NOT NULL,
  `Aditivo_id` INT NOT NULL,
  PRIMARY KEY (`Especie_nombre`, `Aditivo_id`),
  INDEX `fk_Especie_has_Aditivo_Aditivo1_idx` (`Aditivo_id` ASC) VISIBLE,
  INDEX `fk_Especie_has_Aditivo_Especie1_idx` (`Especie_nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Especie_has_Aditivo_Especie1`
    FOREIGN KEY (`Especie_nombre`)
    REFERENCES `MeGusta`.`Especie` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Especie_has_Aditivo_Aditivo1`
    FOREIGN KEY (`Aditivo_id`)
    REFERENCES `MeGusta`.`Aditivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Zona_has_Semilla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Zona_has_Semilla` (
  `Zona_nombre` VARCHAR(50) NOT NULL,
  `Semilla_id` INT NOT NULL,
  PRIMARY KEY (`Zona_nombre`, `Semilla_id`),
  INDEX `fk_Zona_has_Semilla_Semilla1_idx` (`Semilla_id` ASC) VISIBLE,
  INDEX `fk_Zona_has_Semilla_Zona1_idx` (`Zona_nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Zona_has_Semilla_Zona1`
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `MeGusta`.`Zona` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zona_has_Semilla_Semilla1`
    FOREIGN KEY (`Semilla_id`)
    REFERENCES `MeGusta`.`Semilla` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Planta_has_Aditivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Planta_has_Aditivo` (
  `Planta_id` INT NOT NULL,
  `Aditivo_id` INT NOT NULL,
  `fecha` DATETIME(4) NULL,
  `cantidad` DOUBLE NULL,
  PRIMARY KEY (`Planta_id`, `Aditivo_id`),
  INDEX `fk_Planta_has_Aditivo_Aditivo1_idx` (`Aditivo_id` ASC) VISIBLE,
  INDEX `fk_Planta_has_Aditivo_Planta1_idx` (`Planta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Planta_has_Aditivo_Planta1`
    FOREIGN KEY (`Planta_id`)
    REFERENCES `MeGusta`.`Planta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Planta_has_Aditivo_Aditivo1`
    FOREIGN KEY (`Aditivo_id`)
    REFERENCES `MeGusta`.`Aditivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Pedido_has_Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Pedido_has_Proveedor` (
  `Pedido_id` INT NOT NULL,
  `Proveedor_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pedido_id`, `Proveedor_nombre`),
  INDEX `fk_Pedido_has_Proveedor_Proveedor1_idx` (`Proveedor_nombre` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Proveedor_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Proveedor_Pedido1`
    FOREIGN KEY (`Pedido_id`)
    REFERENCES `MeGusta`.`Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Proveedor_Proveedor1`
    FOREIGN KEY (`Proveedor_nombre`)
    REFERENCES `MeGusta`.`Proveedor` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeGusta`.`Plantacion_has_Aditivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MeGusta`.`Plantacion_has_Aditivo` (
  `Plantacion_id` INT NOT NULL,
  `Aditivo_id` INT NOT NULL,
  PRIMARY KEY (`Plantacion_id`, `Aditivo_id`),
  INDEX `fk_Plantacion_has_Aditivo_Aditivo1_idx` (`Aditivo_id` ASC) VISIBLE,
  INDEX `fk_Plantacion_has_Aditivo_Plantacion1_idx` (`Plantacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_Plantacion_has_Aditivo_Plantacion1`
    FOREIGN KEY (`Plantacion_id`)
    REFERENCES `MeGusta`.`Plantacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plantacion_has_Aditivo_Aditivo1`
    FOREIGN KEY (`Aditivo_id`)
    REFERENCES `MeGusta`.`Aditivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;