(:1.    Mostrar los títulos de los libros con la etiqueta "titulo".:)
(: data(doc("books.xml")/bookstore/book/@category) :)

(:2.    Mostrar los libros cuyo precio sea menor o igual a 30. Primero incluyendo la condición en la cláusula "where" y luego en la ruta del XPath.:)
(:for $x in doc("books.xml")/bookstore/book[price<=30]
return data($x/@category):)

(:3. Mostrar el título y el autor de los libros del año 2005, y etiquetar cada uno de ellos con "lib2005".:)
(:<libreria>
{
  for $x in doc("books.xml")/bookstore/book
  where $x/price<=30
  return
    <lib2005>
      {$x/title}
      {$x/author}
    </lib2005>
}
</libreria>:)

(:4.Mostrar los años de publicación, primero con "for" y luego con "let" para comprobar la diferencia entre ellos. Etiquetar la salida con "publicacion".:)
(: for $x in doc("books.xml")/bookstore/book
return
<publicacion>{$x/year}</publicacion> :)
(: let $x := doc("books.xml")/bookstore/book/year
return <publicacion>{$x}</publicacion> :)

(: 5. Mostrar los libros ordenados primero por "category" y luego por "title" en una sola consulta. :)
(: for $x in doc("books.xml")/bookstore/book
order by $x/@category, $x/title
return
<libros categoria = "{$x/@category}">
  {$x/title}
</libros> :)

(: 6. Mostrar cuántos libros hay, y etiquetarlo con "total". :)
(: let $x := count(doc("books.xml")/bookstore/book)
return <total>{$x}</total> :)

(: 7. Mostrar el precio mínimo y máximo de los libros. :)
(: let $x := max(doc("books.xml")/bookstore/book/price)
let $y := min(doc("books.xml")/bookstore/book/price)
return <libros>
         <maximo>{$x}</maximo>
         <minimo>{$y}</minimo>
       </libros> :)
       
(: 8. Mostrar el título del libro, su precio y su precio con el IVA incluido, cada uno con su propia etiqueta. Ordénalos por precio con IVA :)
(: for $x in doc("books.xml")/bookstore/book
return <libro>
  <titulo>{$x/title}</titulo>
  <precio>{$x/price}</precio>
  <precioIVA>{$x/price * 1.21}</precioIVA>
</libro> :)

(:9. Mostrar la suma total de los precios de los libros con la etiqueta
"total".:)
(:let $x := sum(doc("books.xml")/bookstore/book/price)
return <total>{$x}</total>:)

(:10. Mostrar cada uno de los precios de los libros, y al final una nueva
etiqueta con la suma de los precios.:)
(:<precios>
{
for $x in doc("books.xml")/bookstore/book/price
return <precio>{$x/text()}</precio>
}
{
let $x := doc("books.xml")/bookstore/book/price
return <precioTotal>{sum($x)}</precioTotal>
}</precios>:)

(:11. Mostrar el título y el número de autores que tiene cada título en
etiquetas diferentes.:)
(:for $x in doc("books.xml")/bookstore/book
return
<libro>
<titulo>{$x/title/text()}</titulo>
<numAutores>{count($x/author)}</numAutores>
</libro>:)

(:12. Mostrar en la misma etiqueta el título y entre paréntesis el número de
autores que tiene ese título.:)
(:for $x in doc("books.xml")/bookstore/book
return <info>libro: {$x/title/text()} ({count($x/author)})</info>:)

(:Ahora, el número de autores se tomará como un atributo de libro.:)
(:
<libreria>
{
for $x in doc("books.xml")/bookstore/book
return <libro autores = "{count($x/author)}">{$x/title/text()}</libro>
}
</libreria>:)

(:13. Mostrar los libros escritos en años que terminen en "3".:)
(:for $x in doc("books.xml")/bookstore/book
where ends-with($x/year, "3")
return $x/title:)

(:Ahora, realizarlo con let:)
(:let $x := doc("books.xml")/bookstore/book[ends-with(year, "3")]
return $x/title:)

(:14. Mostrar los libros cuya categoría empiece por "C".:)
(:for $x in doc("books.xml")/bookstore/book
where starts-with($x/@category, "C")
return $x:)

(:15. Mostrar los libros que tengan una "X" mayúscula o minúscula en el título
ordenados de manera descendente.:)
(: for $x in doc("books.xml")/bookstore/book
where contains($x/title, "X") or contains($x/title, "x")
order by $x/title/ascending
return $x/title :)

(: Consultas a parte :)

(: 19.Mostrar el título y el número de caracteres que tiene cada título, cada uno con su propia etiqueta. :)
(:for $x in doc("books.xml")/bookstore/book
return
<libro>
  <título>{$x/title/text()}</título>
  <numCaract>{string-length($x)}</numCaract>
</libro>:)

(: 20.Mostrar todos los años en los que se ha publicado un libro eliminando los repetidos. Etiquétalos con "año". :)
(: for $x in distinct-values(doc("books.xml")/bookstore/book/year)
return
<año>{$x}</año> :)

(: 21.Mostrar todos los autores eliminando los que se repiten y ordenados por el número de caracteres que tiene cada autor. :)
(: for $x in distinct-values(doc("books.xml")/bookstore/book/author)
return
<libro>
<autores>{$x} - {string-length($x)}</autores>
</libro> :)

(: 22.Mostrar los títulos en una lista de HTML. :)
(:<ul>{for $x in doc("books.xml")/bookstore/book
return <li>{$x/title/text()}</li>}</ul>:)
