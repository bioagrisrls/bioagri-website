

<script defer>

    Component.register('ui-contact-us', (id, props) => new class extends FormComponent {

        constructor() {
            super(id, {

                name: {
                    type: 'text',
                    label: 'Nome', // FIXME,
                    required: true,
                    maxlength: 32
                },

                surname: {
                    type: 'text',
                    label: 'Cognome', // FIXME,
                    required: true,
                    maxlength: 32
                },

                email: {
                    type: 'email',
                    label: "Indirizzo email", // FIXME
                    pattern: /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/,
                    required: true,
                    size: 128, // FIXME
                    wrong: "Username wrong! (FIXME)"
                },

                phone: {
                    type: 'tel',
                    label: 'Recapito telefonico', // FIXME
                    required: true,
                    size: 16
                },

                object: {
                    type: 'text',
                    label: 'oggetto', // FIXME,
                    required: true,
                    maxlength: 32
                },
                message: {
                    type: 'textarea',
                    label: 'scrivi qui il tuo messaggio', // FIXME,
                    required: true,
                    maxlength: 512
                },

                $submit: {
                    value: `${locale.support_contact_us_by_email_button}`,
                    align: 'center'
                },

            });
        }

        onReady(state) {
            this.state = { $state: 'ready-to-send-email' };
        }


        onSubmit(data) {

            console.log(this.state.email);

            Email.send({
                Host: "smtp.elasticemail.com",
                Username: 'davidecrisafull2009@libero.it',
                Password: "DCB69D8ED84CB4F5102BE9E0AEE875FD610C",
                To: 'davidecrisafull2015@gmail.com',
                From: 'info@elasticemail.com',
                Subject: 'prova',
                Body: 'prova messaggio',
            }).then(function (message) {
                alert("mail sent successfully")
            });
        }
    })

</script>