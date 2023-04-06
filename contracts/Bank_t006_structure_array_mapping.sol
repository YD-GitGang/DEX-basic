// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

contract structureArrayMapping {

    struct Kitty{
        string name;
        address owner;
        uint id;
    }

    Kitty[] kitties;
    mapping(address => uint[])addressToId;
    mapping(string => uint)nameToId;

    function addKitty(string memory _name, address _owner) public {
        uint id = kitties.length;
        Kitty memory newKitty = Kitty(_name, _owner, id);
        kitties.push(newKitty);

        addressToId[_owner].push(id);
        nameToId[_name] = id;
    }

    function getNameFromAddress(address _owner) public view returns(string[] memory){
        string[] memory names = new string[](addressToId[_owner].length);

        for(uint i=0; i < addressToId[_owner].length; i++){
            uint id = addressToId[_owner][i];
            names[i] = kitties[id].name;
        }
        return names;

        /*
        string[] memory names;

        for(uint i=0; i<addressToId[_owner].length; i++){
            uint id = addressToId[_owner][i];
            names.push(kitties[id].name);
        }
        return names;
        */
    }

    function getNameFromAddressTest1(address _owner) public view returns(string[] memory){
        string[] memory names;

        for(uint i=0; i < addressToId[_owner].length; i++){
            uint id = addressToId[_owner][i];
            names[i] = kitties[id].name;
        }
        return names;
    }

    function getNameFromAddressTest2(address _owner) public view returns(string[10] memory){
        string[10] memory names;

        for(uint i=0; i < addressToId[_owner].length; i++){
            uint id = addressToId[_owner][i];
            names[i] = kitties[id].name;
        }
        return names;
    }

    /*
    function getIdFromAddress(address _owner) public view returns(uint[] memory){
        return addressToId[_owner];
    }
    
    function getAddressFromId(uint _id) public view returns(address){
        return kitties[_id].owner;
    }
    
    function getNameFromId(uint _id) public view returns(string memory){
        return kitties[_id].name;
    }
    
    function getAddressFromName(string memory _name) public view returns(address){
        uint id = nameToId[_name];
        return kitties[id].owner;
    }
    
    function getIdFromName(string memory _name) public view returns(uint){
        return nameToId[_name];
    }
    */

}