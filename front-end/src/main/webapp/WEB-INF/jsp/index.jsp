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

<!DOCTYPE html>
<html>
    <head>
        <title>Hello World!</title>
        <script src="/assets/js/third-party/js.cookie-2.2.1.min.js"></script>
        <script src="/assets/js/back-end/api.js"></script>
    </head>
    <body>
        <h1>Hello World!</h1>
        UserId: <span id="userId">Loading...</span><br>
        UserRole: <span id="userRole">Loading...</span><br>
        Categories: <span id="categoriesCount"></span><br>
        <div id="component"></div>
    </body>
</html>

<script type="module">

    authenticate('user@test.com', '123').then(response => {

        document.getElementById('userId').innerHTML = response.userId;
        document.getElementById('userRole').innerHTML = response.userRole;

    }).then(response => {

        api('/categories').then(response => {
            document.getElementById('categoriesCount').innerHTML = response.length;
        }).catch(reason => {
            console.error(reason);
        })

    });

    render('#component', {

        template: `
            <div>
                <h1>Component Sample</h1>
                <h4>{{ message }}</h4>
            </div>
        `,

        data: {
            message: "Hello World!"
        }

    });

</script>