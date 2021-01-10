# UrnaEletronica
Purpose
The main objective of this publish is suggest an example of smart contract running in a blockchain platform that execute the same functions of a Brazilian electronic ballot box.

Introduction
Smart contract is a technology that consist in formalize contract rules through an algorithm, this code is written in solidity language, and is executed in a data decentralized platform named blockchain, which is simulated in the IDE remix ethereum, allowing automatic events, real time information, transparency, rastreability, immutability and data security.


Development
In the Brazilians elections, there are an electronic ballot box, responsible to count the voting in each electoral college that allows the electors to type the candidate number. This equipment is demonstrated bellow:


There is a remote control, normally operated by a poll worker, which allows insert the elector identification number, to verify if the same elector have voted earlier, this verification is important for ensure that the elector can’t vote more than one time in the same election. Also, the poll worker need print a record after and other before the voting period, to prove that the electronic ballot box was started with zero votes (default configuration), and show the result of the computed votes in the end.


Constructor:

```
constructor(uint _ElectoralWard, uint _VotingSection) public  { 
        ElectoralWard = _ElectoralWard;
        VotingSection = _VotingSection;
        BallotBoxAdress = msg.sender;
    }
```
Start Voting:
```
function StartVoting() public verification1(){ 
    
        TimeStampStart = block.timestamp; 
    }
```
First printing:
```
function FirstPrinting() public view verification1() returns(uint zona, uint VotingSection, uint _TimeStampStart, uint _CandidateA, uint _CandidateB, uint _BlankVotes, uint _NullVotes){


        return( ElectoralWard,
                VotingSection,
                TimeStampStart,
                CandidateA,
                CandidateB,
                BlankVotes,
                NullVotes);
    }
Enable poll worker:

function EnablePollWorker()public{
        RemoteControllAdress = msg.sender; 
    }
```
Insert elector ID:
```
function InsertElectorID(uint _ElectorID) public verification2 {
       
        for(uint i=0; i < ElectorID.length; i++){ 
            if(_ElectorID == ElectorID[i]){ 
                    AlreadyVoted = true;
            }
        }
        if(AlreadyVoted == false){ 
            ElectorID.push(_ElectorID); 
        }
    }
Enable electronic ballot box:

function EnableElectronicBallotBox() public verification4(){
        BallotBoxAdressEnable = true; 
    }
```
To vote:
```
function ToVote(uint voto) public verification3(BallotBoxAdressEnable){
        if(BallotBoxAdressEnable == true){ 
            if(voto == NumberCandidateA){
                CandidateA++; 
            }
            else if(voto == NumberCandidateB){
                CandidateB++; 
            }
            else if(voto == NumberBlankVotes){
                BlankVotes++; 
            }
            else{
                NullVotes++;
            }
        }
        BallotBoxAdressEnable = false; 
    }
```
Finish voting:
```
function FinishVoting() public verification1(){
        TimeStampEnd = block.timestamp; 
        BallotBoxAdressEnable = false; 
    }
```
Last printing:
```
function LastPrinting() public view verification1() returns(uint zona, uint VotingSection, uint _TimeStampEnd, uint _CandidateA, uint _CandidateB, uint _BlankVotes, uint _NullVotes){ // retorna o resultado da votação naquela BallotBoxAdress


        return( ElectoralWard,
                VotingSection,
                TimeStampStart,
                CandidateA,
                CandidateB,
                BlankVotes,
                NullVotes);
    }
```
Verifications:
```
modifier verification1(){
        require(msg.sender == BallotBoxAdress, "This command need come from the electronic Ballot Box Adress");
        _;
    }
    modifier verification2(){
        require(msg.sender == RemoteControllAdress, "This command need come from the poll worker Adress");
        _;
    }
    modifier verification3(bool status){
        require(msg.sender == BallotBoxAdress, "This command need come from the electronic Ballot Box Adress");
        _;
        require(status == true, "The electronic ballot box is disable, because this elector already voted");
        _;
    }
    modifier verification4(){
        require(msg.sender == RemoteControllAdress, "This command need come from the poll worker Adress");
        _;
        require(AlreadyVoted == false, "The electronic ballot box is disable, because this elector already voted");
        _;
    }
    
```

Conclusion
This exercise, demonstrated that is possible use the blockchain technology in the Brazilian elections. Obviously this code need be improved a lot to avoid fraud and to end up in the same level of the Brazilian electronic ballot box, but it is a good example to demonstrate this new techonlogy of smart contracts. The future objectives can be create a web interface to represent the ballot box and the remote control, also develop a test code, to test all posibilities of this algorithm and avoid bugs.

https://www.linkedin.com/pulse/smart-contract-example-elections-blockchain-platform-borba/
