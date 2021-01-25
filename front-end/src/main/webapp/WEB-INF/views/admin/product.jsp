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


<form action="/admin/form/product" method="POST">

        <label>titolo</label>
        <input type="text" id="name" name="name"><br><br>
        <label >descrizione:</label>
        <input type="text" id="description" name="description"><br><br>
        <label >descrizione breve:</label>
        <input type="text" id="info" name="info"><br><br>
        <label >prezzo:</label>
        <input type="text" id="price" name="price"><br><br>
        <label >giacenza</label>
        <input type="text" id="stock" name="stock"><br><br>
        <label >sconto</label>
        <input type="text" id="discount" name="discount"><br><br>
        <label >status</label>
        <input type="text" id="status" name="status"><br><br>
        <input type="submit" onclick="redirect()"  value="Submit">
    </form>

    <label >immagine</label>
    <input type="file" id="immgine" name="immagine" multiple = "true"><br><br>

<script>

        function redirect() {
                location.replace("/admin/dashboard");
        }
</script>

</body>
</html>