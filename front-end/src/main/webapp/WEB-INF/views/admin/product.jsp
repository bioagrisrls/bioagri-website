<%--
  ~ MIT License
  ~
  ~ Copyright (c) 2020 BioAgri S.r.l.s.
  ~
  ~ Permission is hereby granted, free of charge, to any person obtaining a copy
  ~ of this software and associated documentation files (the "Software"), to deal
  ~ in the Software without restriction, including without limitation the rights
  ~ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  ~ copies of the Software, and to permit persons to whom the Software is
  ~ furnished to do so, subject to the following conditions:
  ~
  ~ The above copyright notice and this permission notice shall be included in all
  ~ copies or substantial portions of the Software.
  ~
  ~ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  ~ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  ~ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  ~ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  ~ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  ~ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  ~ SOFTWARE.
  ~
  --%>

<html>

<head>
</head>

<body>

<h1> crea prodotto </h1>

<form action="/admin/create/product" method="POST">

        <label>titolo</label>
        <input type="text"  name="name"><br><br>
        <label >descrizione:</label>
        <input type="text"  name="description"><br><br>
        <label >descrizione breve:</label>
        <input type="text" name="info"><br><br>
        <label >prezzo:</label>
        <input type="text"  name="price"><br><br>
        <label >giacenza</label>
        <input type="text"  name="stock"><br><br>
        <label >sconto</label>
        <input type="text"  name="discount"><br><br>
        <label >status</label>
        <input type="text" name="status"><br><br>
        <label >immagine</label>
        <input onchange="getFile(this)" type="file" id="immgine" name="image" multiple = "true"><br><br>
        <input type="submit" value="Submit">


    </form>



<h1>aggiorna prodotto</h1>

<form action="/admin/update/product" method="POST">

        <label>id</label>
        <input type="text"  name="id"><br><br>
        <label>titolo</label>
        <input type="text"  name="name"><br><br>
        <label >descrizione:</label>
        <input type="text"  name="description"><br><br>
        <label >descrizione breve:</label>
        <input type="text"  name="info"><br><br>
        <label >prezzo:</label>
        <input type="text"  name="price"><br><br>
        <label >giacenza</label>
        <input type="text" name="stock"><br><br>
        <label >sconto</label>
        <input type="text"  name="discount"><br><br>
        <label >status</label>
        <input type="text" name="status"><br><br>
        <input type="submit" value="Submit">

</form>


<h1>elimina prodotto</h1>

<form action="/admin/delete/product" method="POST">

        <label>id</label>
        <input type="text" name="id"><br><br>
        <input type="submit" value="Submit">

</form>


</body>
</html>