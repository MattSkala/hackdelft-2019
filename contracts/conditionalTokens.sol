pragma solidity >=0.4.0 <0.7.0;

contract conditionalTokens {
    struct Company{
        uint8 exists;
        uint256 balance;
        string name;
    }

    struct Claim{
        address company;
        uint256 priceLimit;
        string city;
        uint startTime;
        uint endTime;
    }

    struct Employee{
        uint8 exists;
        string name;
        string homeCity;
        address payable company;
    }

    struct ServiceProvider{
        uint exists;
        string name;
        string location;
    }

    mapping(address=>Company) public allCompanies;
    mapping(address=>Employee) public allEmployee;
    mapping(address=>address[]) public companyEmployees;
    mapping(address=>ServiceProvider) public allServiceProviders;

    function addCompany(string memory name) public payable{
        require(allCompanies[msg.sender].exists!=1);
        Company memory newCompany = Company(1, msg.value, name);
        allCompanies[msg.sender] = newCompany;
    }

    function refillAccount() public payable{
        require(allCompanies[msg.sender].exists==1);
        allCompanies[msg.sender].balance = msg.value;
    }

    function addServiceProvider(string memory name, string memory location) public payable{
        require(allServiceProviders[msg.sender].exists!=1);
        ServiceProvider memory newServiceProvider = ServiceProvider(1,name,location);
        allServiceProviders[msg.sender] = newServiceProvider;
    }
   /*
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
