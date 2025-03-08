// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HelloWorld {
    string public greet = "hello world!";

}

contract Counter {
    uint256 public count =10;

    function get() public view returns(uint256) {
        return count;
    }
    function inc() public {
        count += 1;
    }

    function dec() public {
        count -= 1;
    }

}

contract Primitives {
    bool public boo = true;

    uint8 public  u8 =1; // 0~2**8-1
    uint256 public u256 = 456; // 0~2**256-1

    /*
    Negative numbers are allowed for int types.
    Like uint, different ranges are available from int8 to int256
    
    int256 ranges from -2 ** 255 to 2 ** 255 - 1
    int128 ranges from -2 ** 127 to 2 ** 127 - 1
    */
    int8 public i8=-1;
    int256 public i256 =456;
    int256 public i =-123; 

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    bool public defaultBoo; //false
    uint256 public defaultUint; //0
    int256 public defaultInt; //0
    address public defaultAddr; //0x0000000000000000000000000000000000000000
}


contract Variables {
    // State variables are stored on the blockchain.
    string public text = "hello";
    uint256 public num = 123;

    function doSomething() public {
        //Local variables are not saved to the blockchain
        uint256 i = 456;

        // Here are some global variables
        uint256 timestamp = block.timestamp;
        address sender = msg.sender; //address of the caller
    }
}

contract Constants {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MY_UNIT = 123;
}

contract Immutable {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}


contract SimpleStorage {
    uint256 public num;

    // You need to send a transaction to write to a state variable.
    function set(uint256 _num) public {
        num = _num;
    }

    // You can read from a state variable without sending a transaction.
    function get() public view returns(uint256) {
        return num;
    }
}


contract EtherUints {
    uint256 public oneWei = 1 wei;

    // 1 wei is equal to 1
    bool public isOneWei = (oneWei==1);

    uint256 public oneGwei = 1 gwei;
    // 1 gwei is equal to 10^9 gwei
    bool public isOneGwei = (oneGwei == 1e9);

    uint256 public oneEther = 1 ether;
    // 1 ether is equal to 10^18 wei
    bool public isOneEther = (oneEther == 1e18);

}

contract Gas {
    uint256 public i = 0;
    function forever() public {
        while (true) {
            i += 1;
        }
    }
}

contract IfElse {
    //TODO pure preable的差异
    function foo(uint256 x) public pure returns (uint256) {
        if (x < 10) {
            return 0;
        } else if(x<20) {
            return 1;
        } else {
            return 2;
        }
    }
}

contract Loop {
    function loop() public pure{
        for(uint256 i =0; i < 10; i++) {
            if(i ==3) {
                continue;
            }
            if(i==5){
                break;
            }
        }

        uint256 j =0;
        while(j < 10){
            j++;
        }
    } 
}

contract Mapping {
    mapping (address => uint256) public myMap;

    function get(address _addr) public view returns (uint256) {
        return myMap[_addr];
    }

    function set(address _addr, uint256 _i) public {
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        delete myMap[_addr];
    }
}


contract NestedMapping {

    // mapping(address => mapping(uint256 => bool)) public nested;

    // function get(address _addr1, uint256 _i) public view returns (bool) {
    //     // You can get values from a nested mapping
    //     // even when it is not initialized
    //     return nested[_addr1][_i];
    // }

    mapping (address => mapping (uint256=>bool)) public nested;

    function get(address _addr1, uint256 _i) public  view returns(bool){
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint256 _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr, uint256 _i) public {
        delete nested[_addr][_i];
    }
}

contract Array {
    uint256[] public arr;
    uint256[] public arr2 =[1,2,3];

    uint256[10] public myFixedSizeArr;

    function get(uint256 i) public view returns(uint256){
        return arr[i];
    }

    function getArr() public view returns(uint256[] memory){
        return arr;
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function pop() public {
        //数组长度减1
        arr.pop();
    }

    function length() public view returns(uint256) {
        return arr.length;
    }

    function remove(uint256 index) public {
        delete arr[index];
    }

    function examples() external {
        // create array in memory, only fixed size can be created
        uint256[] memory a = new uint256[](5);
    }
}

contract ArrayRemoveByShifting {

    uint256[] public arr;

    function remove(uint256 _index) public {
        require(_index < arr.length, "index out of bound");

        for(uint256 i = _index; i < arr.length -1; i++) {
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1,2,3,4,5];
        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 3);
        assert(arr[3] == 4);
    }

}

contract ArrayReplaceFromEnd {
    uint256[] public arr;

    function remove(uint256 index) public {
        arr[index] = arr[arr.length - 1];
        // Remove the last element
        arr.pop();
    }

    function test() public {
        arr = [1,2,3,4];

        remove(1);
        assert(arr.length ==3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        assert(arr.length ==2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }

}

contract Enum {
    enum Status {
        Pending,
        Shipping,
        Accepted,
        Rejected,
        Canceled
    }

    Status public status;

    function get() public view returns(Status) {
        return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    function cancel() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status;
    }

}


contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(string calldata _text) public {
        // 3 ways to initialize a struct
        // - calling it like a function
        todos.push(Todo(_text, false));

        // key value mapping
        todos.push(Todo({text: _text, completed: false}));

        // initialize an empty struct and then update it
        Todo memory todo;
        todo.text = _text;
        // todo.completed initialized to false

        todos.push(todo);
    }

    // Solidity automatically created a getter for 'todos' so
    // you don't actually need this function.
    function get(uint256 _index)
        public
        view
        returns (string memory text, bool completed)
    {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // update text
    function updateText(uint256 _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // update completed
    function toggleCompleted(uint256 _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }

}