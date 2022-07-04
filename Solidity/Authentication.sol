// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;]

import "@openzeppelin/contracts/utils/Strings.sol";

contract Auth {
    struct PatientDetail
     {
        address addr;
        string name;
        string password;
        string id;
        string age;
        string sex ;
        bool isUserLoggedIn ;
        
    }
    struct DoctorDetail
    {
        address addr ;
        
        string name ;
        string password ;
        string id ;
        string age;
        string sex ;
        bool isUserLoggedIn ;
    }
    uint pid = 0 ;
    uint did = 0 ;
    mapping(address => PatientDetail) patient;
    mapping(address=>DoctorDetail) doctor ;

    // user registration function
    function registerPatient(
        address _address,
        string memory _name,
        string memory _password,
        string memory _age,
        string memory _sex 
    ) public returns (bool) {
       bool a = false ;
       if(a == false) 
        { require((patient[_address].addr != msg.sender));
         pid = pid + 1 ;
         string memory ppid = Strings.toString(pid) ;
         string memory _pid = concat("p",ppid) ;
         patient[_address].addr = _address;
         patient[_address].name = _name;
         patient[_address].password = _password;
         patient[_address].id = _pid;
         patient[_address].age = _age;
         patient[_address].sex = _sex ;
         patient[_address].isUserLoggedIn = false;
         a = true;
        }
        return a ;
    
    }

    function registerDoctor(
        address _address,
        string memory _name,
        string memory _password,
        string memory _age,
        string memory _sex

    ) public returns (bool)
    {  bool b = false ;
     
        if(b==false)
        {
            require(doctor[_address].addr != msg.sender);
            did = did + 1 ;
            string memory ddid = Strings.toString(did) ;
            string memory _did = concat("d",ddid) ;
            doctor[_address].addr = _address;
            doctor[_address].name = _name;
            doctor[_address].password = _password;
            doctor[_address].id = _did;
            doctor[_address].age= _age ;
            doctor[_address].sex = _sex ;
            doctor[_address].isUserLoggedIn = false;
            b = true ;
            return b;
        }
        return b ;   

    }

    // user login function
    function loginPatient(address _address, string memory _password)
        public
        returns (bool)
    {
        if (
            keccak256(abi.encodePacked(patient[_address].password)) ==
            keccak256(abi.encodePacked(_password))
        ) {
            patient[_address].isUserLoggedIn = true;
            return patient[_address].isUserLoggedIn;
        } else {
            return false;
        }
    }

    function loginDoctor(address _address, string memory _password)
        public
        returns (bool)
    {
        if (
            keccak256(abi.encodePacked(doctor[_address].password)) ==
            keccak256(abi.encodePacked(_password))
        ) {
            doctor[_address].isUserLoggedIn = true;
            return doctor[_address].isUserLoggedIn;
        } else {
            return false;
        }
    }

    // check the user logged In or not
    function checkIsPatientLogged(address _address) public view returns (string memory,string memory,string memory,string memory)
    {
        require(patient[_address].isUserLoggedIn);
        return(patient[_address].name,patient[_address].age,patient[_address].id,patient[_address].sex);
    }
    function checkIsDoctorLogged(address _address) public view returns (string memory,string memory,string memory,string memory)
    {
        require(doctor[_address].isUserLoggedIn);
        return(doctor[_address].name,doctor[_address].age,doctor[_address].id,doctor[_address].sex);
    }

    // logout the user
    function logoutPatient(address _address) public 
    {
        patient[_address].isUserLoggedIn = false;
    }
    function logoutDoctor(address _address) public 
    {
        doctor[_address].isUserLoggedIn = false;
    }

    

    function concat(string memory a,string memory b) public pure returns (string memory)
    {
        return string(abi.encodePacked(a,'',b));
    } 
    function CheckLoc(string memory Lat, string memory Lon) public view returns(bool)
    {
           

        if( ( keccak256(abi.encodePacked(Lat))==keccak256(abi.encodePacked("12.9078")) || keccak256(abi.encodePacked(Lat))==keccak256(abi.encodePacked("12.9077"))|| (keccak256(abi.encodePacked(Lat))==keccak256(abi.encodePacked("12.9079"))) )
         &&
         (keccak256(abi.encodePacked(Lon)) == keccak256(abi.encodePacked("77.5661")) || keccak256(abi.encodePacked(Lon)) == keccak256(abi.encodePacked("77.5662")) ||( keccak256(abi.encodePacked(Lon)) == keccak256(abi.encodePacked("77.5663")) || keccak256(abi.encodePacked(Lon)) == keccak256(abi.encodePacked("77.5664")) ) ) 
        )
            {
                return(true) ;
            }
        else 
            {
                return(false);
            }

    }
   
}
