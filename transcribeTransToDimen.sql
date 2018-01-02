-- -----------------------------------------------------
-- Transcribe Data from `transccine` to `dimcine`
-- -----------------------------------------------------

use `transccine`;

DROP VIEW IF EXISTS dimPelicula;
DELIMITER $$
CREATE VIEW dimPelicula AS
SELECT Pelicula.id as 'id', Pelicula.titulo_original as 'Nombre', sum(Roles.salario) as 'Presupuesto'FROM Pelicula
inner join Pelicula_Persona on Pelicula.id = Pelicula_Persona.Pelicula_id
inner join Roles on Pelicula_Persona.Roles_id = Roles.id
group by Pelicula.id;
$$
DELIMITER ;

DROP VIEW IF EXISTS generosPelicula;
DELIMITER $$
CREATE VIEW generosPelicula AS
SELECT Pelicula.id as 'id', group_concat(Genero.tipo separator '|') as 'genero'FROM Pelicula
inner join Genero_Pelicula on  Pelicula.id = Genero_Pelicula.Pelicula_id
inner join Genero on Genero_Pelicula.Genero_id = Genero.id
group by Pelicula.id;
$$
DELIMITER ;


DROP VIEW IF EXISTS general_dimensional_view;
DELIMITER $$
CREATE VIEW general_dimensional_view AS
select dimPelicula.Nombre as 'Pelicula', dimPelicula.Presupuesto as 'Presupuesto', generosPelicula.genero as 'Genero',
		Pelicula.clasificacion as 'Clasificacion', Sala.nombre as 'Sala', Sala.aforo as 'Aforo',
        promocion.descuento as 'Descuento', promocion.descripcion as 'Descripcion Descuento',
        Cine.Nombre as 'Cine', Funcion.dia as 'Fecha'
from dimPelicula
inner join Pelicula on dimPelicula.id = Pelicula.id
inner join Funcion on Pelicula.id = Funcion.Pelicula_id
inner join promocion on Funcion.id = promocion.Funcion_id
inner join Sala on Sala.id = Funcion.Sala_id
inner join Cine on Cine.id = Sala.Cine_id
inner join generosPelicula on generosPelicula.id = dimPelicula.id;
$$
DELIMITER ;

select * from general_dimensional_view;

DROP function IF EXISTS transcribe;
DELIMITER $$
CREATE procedure transcribe()
Begin
	
    declare pelicula varchar(200);
    declare presupuesto int(20);
    declare genero varchar(200);
    declare clasificacion varchar(45);
    declare sala varchar(45);
    declare aforo int(11);
    declare descuento float(4,4);
    declare descripcion_descuento text(200);
    declare cine varchar(60);
	declare fecha date;
	
    declare semana int(2);
    declare mes int(2);
    declare año year(4);
    declare trimestre int(1);
    
    declare master_id int;
    
    declare master_reader Cursor for select * from general_dimensional_view;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    set master_id = 0;
    open master_reader;
    
    truncate table `dimcine`.`Hechos`;
    
    read_loop: loop
		fetch master_reader into pelicula, presupuesto, genero,
									clasificacion, sala, aforo,
                                    descuento, descripcion_descuento,
                                    cine, fecha;
        
        insert into `dimcine`.`Peliculas` (`id`, `Nombre`, `presupuesto`) Values (master_id, pelicula, presupuesto);
        insert into `dimcine`.`Genero` (`id`, `tipo`) Values (master_id, genero);
        insert into `dimcine`.`Clasificacion` (`id`, `rango`) values (master_id, clasificacion);
        insert into `dimcine`.`Sala` (`id`, `Nombre`) values (master_id, sala);
        insert into `dimcine`.`Aforo` (`id`, `asistentes`) values (master_id, aforo);
        insert into `dimcine`.`Promocion` (`id`, `Descuento`, `Descripcion`) values (master_id, descuento, descripcion_descuento);
        insert into `dimcine`.`Cine` (`id`, `Nombre`) values (master_id, cine);
        
        set semana = week(fecha);
        set mes = month(fecha);
        set año = year(fecha);
        set trimestre = (mes - (mes % 4)/ 4) + 1;
        
        insert into `dimcine`.`Fecha` (`id`, `fecha`, `semana`, `mes`, `año`, `trimestre`) values
			(master_id, fecha, semana, mes, año, trimestre);
            
		insert into `dimcine`.`Hechos` (`id`, `Peliculas_id`, `Promocion_id`, `Fecha_id`, `Sala_id`, `Clasificacion_id`,
										`Cine_id`, `Genero_id`, `Aforo_id`) Values (master_id, master_id, master_id,
																			master_id, master_id, master_id, master_id,
                                                                            master_id, master_id);
        
        if done then
			leave read_loop;
		end if;
        
        set master_id = master_id + 1;
	end loop;
    close master_reader;
end;
$$
DELIMITER ;