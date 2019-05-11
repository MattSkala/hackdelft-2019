/*jshint esversion: 8 */
function main(a){
  return a;
}

Events = {
  listen_transfer: async function(companyAddress, run) {
    filter = {companyAddress: companyAddress};
    additionalFilter = {fromBlock: 0, toBlock: 'latest'};
    transferEvent = App.contract.transfer(filter, additionalFilter);
    transferEvent.watch(function(error, result){
     if (!error){
       console.log("Refer Event:");
       console.log(result);
       run(result);
     }
    });
  },

  init_events: async function() {
      console.log("Events are initialised!!");
      Events.listen_transfer("0x369e32aed1dc5c33c85ab20977fb645a803e4a70", main);
  }

};
