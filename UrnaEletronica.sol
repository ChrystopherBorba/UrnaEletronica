pragma solidity ^0.5.17;

contract UrnaEletronica{
  

    uint ZonaEleitoral; // variável que representa a Zona eleitoral em que a urna se encontra
    uint Secao; // variável que representa a Seção eleitoral em que a urna se encontra
    
    uint DataHoraInicio; // Variável que representa a data de início da votação 
    uint DataHoraFim; // Variável que representa a data final da votação 
    
    uint CandidatoA = 0; // Variável que representa o número de votos do candidato A
    uint CandidatoB = 0; // Variável que representa o número de votos do candidato B
    uint Branco = 0; // Variável que representa o número de votos em branco
    uint Nulo = 0; // Variável que representa o número de votos nulos
    
    uint nCandidatoA = 1; //Valor que representa a legenda do candidato A
    uint nCandidatoB = 2; //Valor que representa a legenda do candidato B
    uint nBranco = 3; // Valor que representa votos em branco
    
    address Urna; // Conta que representa os comandos vindos da Urna eletrônica
    address Mesario; // Conta que representa os comandos vindos do controle remoto do Mesário
    
    
    uint[] TituloDeEleitor; // Lista que acumula o número dos títulos dos eleitores que já votaram

    bool EleitorJaVotou = false; // Variável que define se o usuário já votou ou não 
    

    bool UrnaLiberada = false; // Variável que define se a Urna eletronica foi liberada ou não 


    
    constructor(uint _ZonaEleitoral, uint _Secao) public  { // Construtor que carrega valores da zona e seção eleitoral
        ZonaEleitoral = _ZonaEleitoral;
        Secao = _Secao;
        Urna = msg.sender;
    }
    
    function IniciarVotacao() public verificacao1(){ 
    
        DataHoraInicio = block.timestamp; // Carrega na variável DataHoraInicio a estampa de tempo atual.
        
    }
    modifier verificacao1(){
        require(msg.sender == Urna, "Este comando só pode partir da Urna Eletrônica");
        _;
    }
    
    function PrimeiraZerezima() public view verificacao1() returns(uint zona, uint secao, uint _DataHoraInicio, uint _CandidatoA, uint _CandidatoB, uint _Branco, uint _Nulo){

        return( ZonaEleitoral,
                Secao,
                DataHoraInicio,
                CandidatoA,
                CandidatoB,
                Branco,
                Nulo);
        
    }
    
    function HabilitarMesario()public{
        Mesario = msg.sender; // Carrega na variável Mesario o endereço que enviou o comando
    }
    modifier verificacao2(){
        require(msg.sender == Mesario, "Este comando só pode partir do controle do mesário");
        _;
    } 
    
    function InserirTituloDeEleitor(uint _TituloDeEleitor) public verificacao2 {
       
        for(uint i=0; i < TituloDeEleitor.length; i++){ // Lê cada valor da lista TituloDeEleitor
            if(_TituloDeEleitor == TituloDeEleitor[i]){ // Se algum valor na lista TituloDeEleitor for igual ao valor de título que está sendo inserido no momento, a variável EleitorJaVotou será verdadeira
                    EleitorJaVotou = true;
            }
        }
        if(EleitorJaVotou == false){ // Caso o eleitor não tanha votado anteriormente
            TituloDeEleitor.push(_TituloDeEleitor); // Inclui o novo título de eleitor a lista
        }

    }
    
    function LiberarUrna() public Liberacao(){
        UrnaLiberada = true; // Caso todas as restrições do modificador Liberação for satisfeito, a variável UrnaLiberada é verdadeira.
    }
    modifier Liberacao(){
        require(msg.sender == Mesario, "Este comando só pode partir do controle do mesário");
        _;
        require(EleitorJaVotou == false, "A urna não pode ser liberada, porque esse eleitor já votou");
        _;
    } 
    
    function Votar(uint voto) public verificacao1(){
        if(UrnaLiberada == true){ // Se a urna estiver liberada
            if(voto == nCandidatoA){
                CandidatoA++; // Se o valor inserido for igual a 1, o voto foi para o candidatoA
            }
            else if(voto == nCandidatoB){
                CandidatoB++; // Se o valor inserido for igual a 2, o voto foi para o candidatoB
            }
            else if(voto == nBranco){
                Branco++; // Se o valor inserido for igual a 3, o voto foi em Branco
            }
            else{
                Nulo++; // Se o valor inserido for diferente de 1, 2 ou 3, o voto foi Nulo
            }
        }
        UrnaLiberada == false; // Após o voto a urna não está mais liberada para votação até a proxima verificação 
    }
    
    function FinalizarVotacao() public verificacao1(){
        DataHoraFim = block.timestamp; // Carrega na variável DataHoraFim a estampa de tempo do final da votação
        UrnaLiberada = false; // Nesse período a urna não pode ser mais liberada para votação
    }
    
      
    function UltimaZerezima() public view verificacao1() returns(uint zona, uint secao, uint _DataHoraFim, uint _CandidatoA, uint _CandidatoB, uint _Branco, uint _Nulo){ // retorna o resultado da votação naquela urna

        return( ZonaEleitoral,
                Secao,
                DataHoraInicio,
                CandidatoA,
                CandidatoB,
                Branco,
                Nulo);
        
    }
}