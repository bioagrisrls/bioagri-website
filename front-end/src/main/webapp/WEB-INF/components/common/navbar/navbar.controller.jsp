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

    Component.register('ui-navbar', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                current: props.current || '',

                title: `${locale.info_title}`,
                logo: `${locale.nav_logo}`,
                home: `${locale.nav_home}`,
                catalog: `${locale.nav_catalog}`,
                about: `${locale.nav_about}`,
                support: `${locale.nav_support}`,
                welcome: `${locale.nav_user_greetings}`,
                account: `${locale.nav_user_account}`,
                order: `${locale.nav_user_order}`,
                wishlist: `${locale.nav_user_wishlist}`,
                settings: `${locale.nav_user_settings}`,
                exit: `${locale.nav_user_exit}`,
                cart: `${locale.nav_shopping_cart}`,
                total: `${locale.nav_shopping_cart_total}`,
                cartOrder: `${locale.nav_shopping_cart_order}`,
                clear: `${locale.nav_shopping_cart_clear}`,
                article: `${locale.nav_shopping_cart_article}`,

                userAccount : '${locale.menu_account}',
                userOrder : '${locale.menu_order}',
                userWishlist : '${locale.menu_wishlist}',
                userExit : '${locale.menu_exit}',

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


            this.onDarkModeSwitched(localStorage.getItem('X-Interface-Dark-Mode') === 'true');

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

        onDarkModeSwitched(checked = undefined) {

            const theme = document.querySelector('#ui-theme-stylesheet');
            const check = document.querySelector('#' + this.id + '-dark-mode');
            const chkbx = document.querySelector('#' + this.id + '-dark-mode-switch');

            if(!theme)
                throw new Error('theme cannot be null');

            if(!check)
                throw new Error('check cannot be null');


            if(checked === undefined)
                checked = !(localStorage.getItem('X-Interface-Dark-Mode') === 'true');


            if(checked) {

                if (theme.attributes['href'] && theme.attributes['href'] !== '/assets/css/ui-bootstrap-dark.min.css')
                    theme.attributes['href'].value = '/assets/css/ui-bootstrap-dark.min.css';

                check.title = '${locale.nav_daymode}';

            } else {

                if (theme.attributes['href'] && theme.attributes['href'] !== '/assets/css/ui-bootstrap.min.css')
                    theme.attributes['href'].value = '/assets/css/ui-bootstrap.min.css';

                check.title = '${locale.nav_nightmode}';

            }


            if(chkbx && !!chkbx.checked !== checked)
                chkbx.checked = checked;


            localStorage.setItem('X-Interface-Dark-Mode', checked.toString());

        }


    });



</script>
