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

    struct ServiceProvider{

    }
    */
    mapping(address=>Company) public allCompanies;

    function addCompany(string memory name) public payable{
        require(allCompanies[msg.sender].exists!=1);
        Company memory newCompany = Company(1, msg.value, name);
        allCompanies[msg.sender] = newCompany;
    }
    /*
    function refillAccount();
    function addEmployee();
    function addServiceProvider();
    function startTrip();
    function payServiceProvider();
    function endTrip();
    function claimAccount();

    //Other Functions
    function getEmployees();
    function getBalance();
    */

}
