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
<%--@elvariable id="authToken" type="it.bioagri.api.auth.AuthToken"--%>

<script defer>

    Component.register('ui-navbar', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                current: props.current || '',
                userRole: `${authToken.userRole}`,

                strings: {

                    title:      `${locale.info_title}`,
                    home:       `${locale.nav_home}`,
                    catalog:    `${locale.nav_catalog}`,
                    about:      `${locale.nav_about}`,
                    support:    `${locale.nav_support}`,

                    userAccount:    `${locale.menu_account}`,
                    userOrder:      `${locale.menu_order}`,
                    userWish:       `${locale.menu_wishlist}`,
                    userTicket:     `${locale.menu_ticket}`,
                    userExit:       `${locale.menu_exit}`,
                    userDashboard:  `${locale.menu_dashboard}`,

                }


            });
        }


        onRender() {
            return `${components.common_navbar}`
        }

        onReady(state) {
            super.onReady(state);


            window.addEventListener('scroll', () => {

                if(!this.running)
                    return;

                if(window.scrollY > 0)
                    this.elem.querySelector('#' + this.id + '-container').classList.add('scrolled');
                else
                    this.elem.querySelector('#' + this.id + '-container').classList.remove('scrolled');


            });


            $(document).on('auth-connection-occurred', () => {

                if (this.running)
                    this.setState({ userRole: sessionStorage.getItem('X-Auth-UserInfo-Role') }, false);

            });

            $(document).on('auth-disconnection-occurred', () => {

                if (this.running)
                    this.setState({ userRole: '' }, false);

            });


            this.switchTheme(localStorage.getItem('X-Interface-Dark-Mode') === 'true');

        }




        onAccountClicked() {

            authenticated()
                .then( () => Component.render(Component.dummy('user-menu'), `${components.users_account_menu}`, this.state))
                .catch(() => Component.render(Component.dummy('user-auth'), `${components.users_account_auth}`, this.state));

        }

        onShoppingClicked() {
            Component.render(Component.dummy('user-cart'), `${components.users_account_cart}`, this.state);
        }

        onSideClicked() {
            Component.render(Component.dummy('side-menu'), `${components.users_account_side}`, this.state);
        }




        /**
         * Change current theme style.
         * @param dark {boolean}
         * @param theme {string}
         */
        switchTheme(dark = undefined, theme = undefined) {


            if(dark === undefined)
                dark = (localStorage.getItem('X-Interface-Dark-Mode') === 'true');

            if(theme === undefined)
                theme = localStorage.getItem('X-Interface-Theme') || 'default';



            const resource = '/assets/css/ui-bootstrap-' + theme + (dark ? '-dark' : '') + ".min.css"

            const style = document.querySelector('#ui-theme-stylesheet');
            const check = document.querySelector('#' + this.id + '-dark-mode');
            const chkbx = document.querySelector('#' + this.id + '-dark-mode-switch');


            if(!style)
                throw new Error('style cannot be null');

            if(!check)
                throw new Error('check cannot be null');




            if (style.attributes['href'] && style.attributes['href'] !== resource)
                style.attributes['href'].value = resource;

            check.title = dark
                ? `${locale.nav_daymode}`
                : `${locale.nav_nightmode}`;



            if(chkbx && !!chkbx.checked !== dark)
                chkbx.checked = dark;


            localStorage.setItem('X-Interface-Dark-Mode', dark.toString());
            localStorage.setItem('X-Interface-Theme', theme.toString());

        }


    });



</script>
