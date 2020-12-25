
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

<%--@elvariable id="components" type="java.util.Map"--%>
<%--@elvariable id="locale" type="java.util.Map"--%>
<%--@elvariable id="reference" type="java.lang.String"--%>


<script defer>

    class FormComponent extends StatefulComponent {

        constructor(state) {
            super(id, state);
        }

        onRender() {
            return `${components.common_form}`;
        }

        onSubmit(data) {

        }

        onInvalid(row) {

        }

        $submit(data) {

            for(let k of Object.keys(data)) {

                if(k in this.state) {

                    const s = this.state[k] || throw new Error("Data has invalid key: " + k);

                    const check = s.check || undefined;
                    const min = s.min || -1;
                    const max = s.max || -1;


                    if(check) {

                        if(typeof check === 'string' && check.test && !check.test(data[k]))
                            return this.onInvalid(k);

                        else if(typeof check === 'function' && !check(data[k]))
                            return this.onInvalid(k);

                        else
                            throw new Error("check must be regex or function");

                    }

                    if(max !== -1 && data[k] > max)
                        return this.onInvalid(k);

                    if(min !== -1 && data[k] < min)
                        return this.onInvalid(k);


                }

            }

            return this.onSubmit(data);

        }

    }

</script>