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
    
    Question[] poolQuestion;
    Player[] poolPlayer;
    
    function getQuestion(uint index)public constant returns(string){
        Question Q = poolQuestion[index];
        return Q._q;
    }
    
    
    function setQuestion(string q)public {
        poolQuestion.length ++;
        uint index = poolQuestion.length-1;
        poolQuestion[index]._q = q;
        poolQuestion[index]._answer.push(true);
        poolQuestion[index]._answer.push(false);
        poolQuestion[index]._oddds.push(1);
        poolQuestion[index]._oddds.push(2);
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