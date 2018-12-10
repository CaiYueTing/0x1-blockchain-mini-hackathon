# 0x1-blockchain-mini-hackathon

## This is my first smart contract with solidity

I wanted to create a DB like NoSQL in solidity.      
And I meet some interesting problem.

<pre>
// global variable
struct Question{
        string _q;
        bool[] _answer;
        uint[] _oddds;
        bool _solve;
        uint _solanswer;
}

Question[] poolQuestion;
</pre>

There was problem when I pushed a struct to struct array.

<pre>
function setQuestion(string q) public {
        Question Q;
        Q._q = q;
        Q._answer.push(true);
        Q._answer.push(false);
        Q._oddds.push(1);
        Q._oddds.push(2);
        poolQuestion.push(Q);
}
</pre>

Because the function had no return, I wanted to get my sturct with index.

<pre>
function getQuestion(uint index)public returns(string){
        return poolQuestion[index]._q;
}
</pre>

The array struct is needed to add length by itself.   
And the problem had been solved.

<pre>
function setQuestion(string q)public {
        poolQuestion.length ++;
        uint index = poolQuestion.length-1;
        poolQuestion[index]._q = q;
        poolQuestion[index]._answer.push(true);
        poolQuestion[index]._answer.push(false);
        poolQuestion[index]._oddds.push(1);
        poolQuestion[index]._oddds.push(2);
}
</pre>
