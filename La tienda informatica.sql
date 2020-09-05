use latiendainformatica;

create table Fabricantes
(codigoFabricante Integer not null,
 nombre varchar (100) not null,
 Primary key (codigoFabricante));
 
 create table Articulo
 (codigoArticulos Integer not null,
 nombre varchar (100) not null,
 precio Double not null,
 codigoFabricante Integer not null, /*tenes que agregar un codigoFabricatnte para clave foranea*/
 Primary key (codigoArticulos),
 Foreign key (codigoFabricante) references Fabricantes(codigoFabricante));

 Insert Into Fabricantes(codigoFabricante,nombre) Values 
 (0001,'FabricanteA'), 
 (0002,'FabricanteB'),
 (0003,'FabricanteC'),
 (0004,'FabricanteD');
 
 Insert Into Articulo(codigoArticulos,nombre,precio,codigoFabricante)
 Values(001,'ArticuloA',1200.0,0001),
		(002,'ArticuloB',140.0,0001),
        (003,'ArticuloC',400.0,0003),
        (004,'ArticuloD',800.0,0004);
        
Insert into Articulo(codigoArticulos,nombre,precio,codigoFabricante)
Values(005,'ArticuloE',60.0,0004);

Insert into Articulo(codigoArticulos,nombre,precio,codigoFabricante)
Values(006,'ArticuloE',120.0,0003);

Insert into Articulo(codigoArticulos,nombre,precio,codigoFabricante)
Values(007,'ArticuloF',300.0,0002);
 
Insert into Articulo(codigoArticulos,nombre,precio,codigoFabricante)
Values(008,'ArticuloG',400.0,0002);

Insert into Articulo(codigoArticulos,nombre,precio,codigoFabricante)
Values(009,'ArticuloH',5000.0,0003);
         
 /*1)Obtener los nombres de los productos de la Tienda*/
	Select nombre from Articulo;
    
/*2)Obtener los nombres y los precios de los productos de la tienda*/
	Select nombre,precio from Articulo;
    
/*3)Obtener el nombre de los productos cuyos precio sea meno o igual a 200*/
	Select nombre From Articulo where precio <= 200;
    
/*4)Obtener todos los datos de los articulos cuyo precio este entre los 60 y los 120*/
	Select * from Articulo where precio  between 60 and 120;
    
/*5)Obtener el nombre y el precio en pesetas 
(es decir, el precio en euros multiplicado por 166.386 )*/

/*Sin As*/	
	Select nombre,precio * 166.386 From Articulo;
    
/*Con As*/
	Select nombre,precio * 166.386 as Pesetas from Articulo;
    
/*6) Selecionar el precio medio de todos los productos*/
	Select AVG(precio) from Articulo;
    
/*7) Obtener el precio medio de los articulos cuyo codigo de fabricante sea 2*/

	Select AVG(precio) from Articulo	
	where codigoFabricante = 0002;
    
/*8)Obtener el numero de articulos cuyo precio sea mayor o igual a 180*/
    Select COUNT(*) from Articulo
    where precio >= 180;
    
/*9)Obtener el nombre y precio de los articulos cuyo precio sea mayor o igual a 180 y
ordenarlos descendentemente por precio y los ascendetemente por nombre*/

	Select nombre,precio from Articulo
	where precio >= 180 order by precio desc,nombre;
    
/*10) Obtener un listado completo de articulos, 
	incluyendo por cada articulo los datos	
	del articulo y de su fabricante*/

/*Sin INNER JOIN*/ /*No funciona*/
Select * from Articulo,codigoFabricante
where codigoFabricante = Fabricantes.codigo;

/*Con INNER JOIN*/
Select * from Articulo 
inner join Fabricantes on
Articulo.codigoFabricante = Fabricantes.codigoFabricante;


/*11)Obtener un listado de articulos , incluyendo el nombre del articulo
,su precio y el nombre de su fabricante*/

/*Inner JOIN*/
Select Articulo.nombre,precio,Fabricantes.nombre 
from Articulo
inner join Fabricantes on
Articulo.codigoFabricante = Fabricantes.codigoFabricante;

/*sin Inner join  (No funciona)*/
Select Articulo.nombre,precio,Fabricantes.nombre
from Articulo,Fabricantes
where Articulos.codigoFabricante = Fabricantes.codigoFabricante;

/*12)Obtener el precio medio de los productos de cada fabricante, mostrando el nombre
del fabricante*/

Select AVG(precio),Articulo.codigoFabricante 
from Articulo
group by Articulo.codigoFabricante;

/*13)Obtener el precio medio de los productos 
de cada fabricante,mostrando el nombre
del fabricante*/
/*Inner JOIN*/
Select Avg(precio),Fabricantes.nombre 
from Articulo inner join Fabricantes
on Articulo.codigoFabricante = Fabricantes.codigoFabricante
group by Fabricantes.nombre;


/*14)Obtener los nombres de los fabricantes 
que ofrezcan productos cuyo precio medio
sea mayor o igual a  150*/

Select Avg(precio),Fabricantes.nombre 
from Articulo inner join Fabricantes on
Articulo.codigoFabricante = Fabricantes.codigoFabricante
group by Fabricantes.nombre
Having AVG(precio) >= 150;

/*15)Obtener el nombre y precio del articulo mas barato*/
Select nombre, precio from Articulo
where precio = (Select MIN(precio) from Articulo);

/*16)Obtener una lista con el nombre y precio de los
articulos mas caros de cada proveedor(incluyendo el nombre del provedor)*/

Select Articulo.nombre, precio,Fabricantes.nombre from Articulo
inner join Fabricantes on
Articulo.codigoFabricante = Fabricantes.codigoFabricante
where precio = (Select MAX(precio) from Articulo);

/*17)Anadir un nuevo producto: Altavoces de 70 del fabricante 2*/
Insert into Articulo(codigoArticulos,nombre,precio,codigoFabricante)
Values(010,'Altavoces',70.0,0002);

/*18)Cambiar el nombre del producto 8 a impresora Laser*/

Update Articulo set nombre ='Impresora Laser'
where codigoArticulos = 008;

/*19) Aplicar un descuento del 10% (multiplicar el precio por 0.9) 
a todos los productos*/

Update Articulo set precio = precio * 0.9;

/*20)Aplicar un descuento de 10 a todos los productos cuyo precio
sea mayor o igual a 120*/

Update Articulo set precio = precio-10
where precio >= 120;