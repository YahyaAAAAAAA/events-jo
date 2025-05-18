const isLocal = false;

//port for local host
const kHostPort = 5000;

//render or localhost
const kHostUrl = isLocal
    ? 'http://localhost:$kHostPort'
    : 'https://eventsjostripebackend.onrender.com';

//endpoints
const kCreateConnectedAccount = '$kHostUrl/create-connected-account';

const kCreateCheckoutSession = '$kHostUrl/create-checkout-session';

const kRefund = '$kHostUrl/refund';

const kTransfer = '$kHostUrl/transfer';

const kBalance = '$kHostUrl/balance';

const kPayouts = '$kHostUrl/payouts';
