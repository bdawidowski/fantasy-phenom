function initStrip(){
    var stripe_public_key = document.querySelector("#stripe-public-key").getAttribute('content');
    var stripe = Stripe(stripe_public_key);
    var elements = stripe.elements();
    // Custom styling can be passed to options when creating an Element.
    var style = {
        base: {
            // Add your base input styles here. For example:
            color: '#fff',
            fontSize: '16px',
            lineHeight: '24px',
            fontSmoothing: 'antialiased',
            fontFamily: 'industry, sans-serif',
            '::placeholder': {
                color: '#cccccc',
                textTransform: 'uppercase'
            },
            iconColor: '#FFF'
        }
    };


    // Create an instance of the card Element
    var card = elements.create('card', {style: style});

    // Add an instance of the card Element into the `card-element` <div>
    card.mount('#card-element');


    card.addEventListener('change', function (event) {
        var displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
        } else {
            displayError.textContent = '';
        }
    });

    // Create a token or display an error when the form is submitted.
    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        var extraDetails = {
            name: form.querySelector('input[name=cardholder-name]').value
        };
        if(document.getElementById('card-errors').textContent == '') {
            stripe.createToken(card, extraDetails).then(function (result) {
                if (result.error) {
                    // Inform the user if there was an error
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                } else {
                    // Send the token to your server
                    stripeTokenHandler(result.token);
                }
            });
        } else {
            document.getElementById('sub-btn').textContent = 'Try Again Please!'
        }
    });

}
function stripeTokenHandler(token) {
    // Insert the token ID into the form so it gets submitted to the server
    var form = document.getElementById('payment-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);

    ["brand", "exp_month", "exp_year", "last4"].forEach(function(field){
        adFieldToForm(form, token, field);
    });

    // Submit the form
    form.submit();
}
function adFieldToForm(form, token, field) {
    // Insert the token ID into the form so it gets submitted to the server
    var form = document.getElementById('payment-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'card_' + field);
    hiddenInput.setAttribute('value', token.card[field]);
    form.appendChild(hiddenInput);
}