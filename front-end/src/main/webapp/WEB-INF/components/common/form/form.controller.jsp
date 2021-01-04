
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

        /**
         * @param id {HTMLElement}
         * @param state {
         *  data[]: {
         *     type: string,
         *     label: string,
         *     required: boolean,
         *     check: object | RegExp | string,
         *     min: number,
         *     max: number
         *  },
         *  submit: string,
         * }
         */
        constructor(id, state) {
            super(id, Object.assign(state, { $state: 'working', $reason: undefined }));
        }

        onRender() {
            return `${components.common_form}`;
        }

        onSubmit(data) {

        }

        onInvalid(row, value) {

        }

        $submit(form, event) {

            event.preventDefault();
            event.stopPropagation();

            if(!form.checkValidity())
                return false;


            const data = {};

            for(let k of Object.keys(this.state)) {

                if(k.startsWith('$'))
                    continue;

                data[k] = $(this.elem).find('#' + this.id + '-' + k).val()  ||
                          $(this.elem).find('#' + this.id + '-' + k).text() ||
                          $(this.elem).find('#' + this.id + '-' + k).prop('checked');

            }


            this.setState({ $state: 'working' });
            this.onSubmit(data);

            return false;

        }


        $check(input) {

            if(input.validity.valid) {

                input.classList.add('is-valid');
                input.classList.remove('is-invalid');

            } else {

                input.classList.add('is-invalid');
                input.classList.remove('is-valid');

            }

            $('#' + this.id + '-form-submit')
                .attr('disabled', !document.forms[this.id + '-form'].checkValidity());

        }

    }


</script>