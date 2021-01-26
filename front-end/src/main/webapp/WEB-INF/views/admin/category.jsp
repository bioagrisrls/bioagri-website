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

<body>

<h1>crea categoria</h1>

<form action="/admin/create/category" method="POST">

    <label>categoria</label>
    <input type="text" name="name"><br><br>
    <input type="submit" value="Submit">

</form>


<h1>aggiorna categoria </h1>
<form action="/admin/update/category" method="POST">

    <label>id</label>
    <input type="text" name="id"><br><br>
    <label>nome</label>
    <input type="text" name="name"><br><br>
    <input type="submit" value="Submit">

</form>



<h1>elimina cateogoria</h1>
<form action="/admin/delete/category" method="POST">

    <label>id</label>
    <input type="text" name="id"><br><br>
    <input type="submit" value="Submit">

</form>


</body>

</html>