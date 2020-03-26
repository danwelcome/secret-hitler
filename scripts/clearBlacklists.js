const Account = require('../../models/account'); // temp
const mongoose = require('mongoose');

mongoose.Promise = global.Promise;
mongoose.connect(`mongodb://${process.env.MONGO_HOSTNAME}/secret-hitler-app`);

let count = 0;

Account.find()
	.lean()
	.eachAsync(account => {
		account.gameSettings.blacklist = [];
		account.save();
		count++;
	})
	.then(() => {
		console.log('done ' + count);
	});
