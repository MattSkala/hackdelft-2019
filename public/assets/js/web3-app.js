/*jshint esversion: 8 */
// default Account: 0x08427F4196800c59c925cb1D0c1BcfcB759f13C6

App = {
  account: '',
  address: '0xa0dfbf1fbd9c7c32700c1c93027409f2936cb1c5',
  contract: '',
  options: {
    from: this.account
  },

  init: function(run) {
    if (typeof web3 !== 'undefined') {
      // If a web3 instance is already provided by Meta Mask.
      web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // Specify default instance if no web3 instance provided
      console.log("Metamask Unavailable");
      return;
    }
    ethereum.enable();
    return App.init_contract(run);
  },

  get_balance: function() {
    web3.eth.getBalance(App.account, (err, wei) => {
      var eth = web3._extend.utils.fromWei(wei, 'ether');
      console.log(eth);
    });
  },

  init_contract: function(run) {
    $.getJSON( "../build/contracts/conditionalTokens.json", function( jsonInterface ) {
      //console.log(jsonInterface);
      App.contract = web3.eth.contract(jsonInterface.abi).at(App.address);
      App.account = web3.eth.defaultAccount;
      App.options.from = web3.eth.defaultAccount;
      console.log(App.contract);
      run();
    });
  },

  addCompany: async function(companyName) {
    await promisify(cb => App.contract.addCompany(companyName, App.options, cb));
  }

};

// Util to make async calls into promises
promisify= (inner) =>
    new Promise((resolve, reject) =>
        inner((err, res) => {
            if (err) {
                reject(err);
            } else {
                resolve(res);
            }
        })
    );
