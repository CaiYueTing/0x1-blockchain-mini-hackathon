pragma solidity ^0.4.24;


/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `ERC20` functions.
 */

contract gambal {
    
    // mapping (uint => string) public strings;
    
    // function test() {
    //     strings[0] = "jeff";    
    // }
    address owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    struct Question{
        string _q;
        bool[] _answer;
        uint[] _oddds;
        bool _solve;
        uint _solanswer;
    }
    
    struct Player {
        address _player;
        uint _q;
        uint _answer;
        uint _money;
        uint _odds;
    }
    
    function strConcat(string _a, string _b, string _c, string _d, string _e) internal returns (string){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory _bd = bytes(_d);
        bytes memory _be = bytes(_e);
        string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        for (i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
        for (i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
        for (i = 0; i < _be.length; i++) babcde[k++] = _be[i];
        return string(babcde);
    }
    
    function strConcat(string _a, string _b) internal returns (string) {
        return strConcat(_a, _b, "", "", "");
    }
    
    Question[] poolQuestion;
    Player[] poolPlayer;
    
    
    function getQuestion(uint index)public constant returns(string){
        string str = poolQuestion[index]._q;
        return str;
    }
    
    
    function setQuestion(string q)public {
        Question QUE;
        QUE._q = q;
        QUE._answer.push(true);
        QUE._answer.push(false);
        QUE._oddds.push(1);
        QUE._oddds.push(2);
        poolQuestion.push(QUE);
    }
    
    function setOdds(uint index, uint odd1, uint odd2) onlyOwner public {
        poolQuestion[index]._oddds[0] = odd1;
        poolQuestion[index]._oddds[1] = odd2;
    }
    
    function setAnswer(uint q, uint a)onlyOwner public {
        require(poolQuestion[q]._solve = false);
        poolQuestion[q]._solve = true;
        poolQuestion[q]._solanswer = a;
        
        uint totalmoney = 0;
        
        for(uint i =0; i<poolPlayer.length;i++){
            if(poolPlayer[i]._q == q){
                totalmoney = totalmoney +poolPlayer[i]._money;
            }
        }
        
        for (uint j=0; j<poolPlayer.length;j++){
            if(poolPlayer[j]._q == q && poolPlayer[j]._answer == a){
                uint pay = poolPlayer[j]._odds * poolPlayer[j]._money;
                poolPlayer[j]._player.transfer(pay);
            }
        }
        
    }
    
    function getOdds(uint index, uint odd) public returns (uint) {
        require(odd>=0);
        return poolQuestion[index]._oddds[odd];
    }
    
    function play(uint q, uint a, uint m) public returns(bool){
        address user = msg.sender;
        Player userp;
        userp._player = user;
        userp._q = q;
        userp._answer = a;
        userp._money =m;
        uint odds  = getOdds(q,a);
        userp._odds = odds;
        poolPlayer.push(userp);
    }

    
}