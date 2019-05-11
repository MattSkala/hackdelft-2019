/*jshint esversion: 8 */
function test(a){
  return a;
}

Events = {
  listenTransefer: async function(companyAddress, run) {
    filter = {companyAddress: companyAddress};
    additionalFilter = {fromBlock: 0, toBlock: 'latest'};
    transferEvent = App.contract.transfer(filter, additionalFilter);
    transferEvent.watch(function(error, result){
     if (!error){
       console.log("Transfer Event:");
       console.log(result);
       run(result);
     }
    });
  },

  listen_claim: async function(companyAddress, run) {
    filter = {companyAddress: companyAddress};
    additionalFilter = {fromBlock: 0, toBlock: 'latest'};
    transferEvent = App.contract.claim(filter, additionalFilter);
    transferEvent.watch(function(error, result){
     if (!error){
       console.log("Claim Event:");
       console.log(result);
       run(result);
     }
    });
  },

  init_events: async function() {
      console.log("Events are initialised!!");
      Events.listenTransefer(App.account, test);
      Events.listenClaim(App.account, test);
  }

};
