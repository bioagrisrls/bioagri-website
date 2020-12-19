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

<div id="navbar"></div>


<script defer>
    // <![CDATA[
    window.counter = 0;
    var navbar;

    authenticate('user@test.com', '123').then(response => {

        navbar = new StatefulComponent('#navbar', {

            render: `${components.common_navbar}`,
            state: { counter: 0 },

            onStateChanged: (state) => {
                //$('#ev').click(() => console.log("CLICKED!"));
            }

            <%--    api('/categories').then(response => {--%>
            <%--    return { categories: response, message: ${locale.info_phone}, clicked: true };--%>
            <%--})--%>

        });

        //$('#navbar').click(() => navbar.setState({clicked:true}));

    });
    // ]]>
</script>