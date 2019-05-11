pragma solidity >=0.4.0 <0.7.0;

contract conditionalTokens {
    struct Company{
        uint8 exists;
        uint256 balance;
        string name;
    }

    struct Claim{
        uint8 exists;
        address company;
        uint256 budget;
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
        string city;
    }

    mapping(address=>Company) public allCompanies;
    mapping(address=>Employee) public allEmployees;
    mapping(address=>address[]) public companyEmployees;
    mapping(address=>ServiceProvider) public allServiceProviders;
    mapping(address=>Claim) public allClaims;

    event transfer(address indexed companyAddress, address indexed employeeAddress, address serviceProvider, uint amount);
    event claim(address indexed companyAddress, address indexed employeeAddress, uint256 budget, string city, uint startTime, uint endTime);
    function addCompany(string memory name) public payable{
        require(allCompanies[msg.sender].exists!=1);
        Company memory newCompany = Company(1, msg.value, name);
        allCompanies[msg.sender] = newCompany;
    }

    function addEmployee(address employeeAddress, string memory name, string memory homeCity) public{
        require(allCompanies[msg.sender].exists==1);
        require(allEmployees[employeeAddress].exists!=1);
        Employee memory newEmployee = Employee(1, name, homeCity, msg.sender);
        allEmployees[employeeAddress] = newEmployee;
        companyEmployees[msg.sender].push(employeeAddress);
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

    function addClaim(address employeeAddress, string memory city, uint256 priceLimit, uint startTime, uint endTime) public {
        require(allCompanies[msg.sender].exists==1);
        require(allEmployees[employeeAddress].exists==1);
        emit claim(msg.sender, employeeAddress, priceLimit, city, startTime, endTime);
        Claim memory newClaim = Claim(1, msg.sender, priceLimit, city, startTime, endTime);
        allClaims[employeeAddress] = newClaim;
    }

    function payServiceProvider(address payable serviceProvider, uint amount) public {
        require(allClaims[msg.sender].exists==1);
        require(allClaims[msg.sender].startTime<now && allClaims[msg.sender].endTime>now);
        require(allServiceProviders[serviceProvider].exists==1);
        require(!strCmp(allClaims[msg.sender].city, allEmployees[msg.sender].homeCity) && strCmp(allClaims[msg.sender].city, allServiceProviders[serviceProvider].city));
        require(allClaims[msg.sender].budget>amount);
        emit transfer(allEmployees[msg.sender].company, msg.sender, serviceProvider, amount);
        serviceProvider.transfer(amount);
    }

    function strCmp(string memory a, string memory b) internal pure returns (bool) {
    if(bytes(a).length != bytes(b).length) {
        return false;
    } else {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}

}
