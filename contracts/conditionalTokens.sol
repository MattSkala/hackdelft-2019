pragma solidity >=0.4.0 <0.7.0;

contract conditionalTokens {
    struct Company{
        uint8 exists;
        uint256 balance;
        string name;
    }
    /*
    struct Employee{

    }
    */
    struct ServiceProvider{
        uint exists;
        string name;
        //string location;
    }
    mapping(address=>Company) public allCompanies;
    mapping(address=>ServiceProvider) public allServiceProviders;

    function addCompany(string memory name) public payable{
        require(allCompanies[msg.sender].exists!=1);
        Company memory newCompany = Company(1, msg.value, name);
        allCompanies[msg.sender] = newCompany;
    }
    /*
    function refillAccount();
    function addEmployee();
    */
    function addServiceProvider(string memory name, address addr) public payable{
       // require(allServiceProviders[addr].exists!=1);
        require(allServiceProviders[addr].exists!=1); //duplicate ServiceProvider
        ServiceProvider memory newServiceProvider = ServiceProvider(1,name);
        allServiceProviders[addr] = newServiceProvider;
    }
    /*
    function startTrip();
    function payServiceProvider();
    function endTrip();
    function claimAccount();

    //Other Functions
    function getEmployees();
    function getBalance();
    */

}
}
