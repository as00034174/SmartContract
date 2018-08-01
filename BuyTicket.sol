contract Buyticket {
    uint public amount;
    address public owner;
    uint public quantityBuy;
    uint public totalReward;
    uint8 public result;
    
    struct Ticket {
        address buyer;
        uint valueItem;
    }
    
    Ticket[] public tickets;
    
    
    constructor (uint _quantity) {
        owner = msg.sender;
        amount = _quantity;
        
    }
    
    function BuyTicket() public payable {
        require(amount > 0);
        require(msg.value % 0.1 ether == 0);
        totalReward += msg.value;     
        for(uint8 i = 0 ; i < uint8(msg.value / 0.1 ether ) ; i++) {
        tickets.push(Ticket (msg.sender, random()));
        amount --;
        }
        
    }
    
    function GetResult() public {
        result = random(); 
    }
    
    function random() private view returns (uint8) {
       return uint8(uint256(keccak256(block.timestamp, block.difficulty))%100);
   }
   
   function sendRewardForWinner() public {
       uint result = random();
       for(uint i = 0 ; i < tickets.length ; i++) {
           Ticket memory ticket = tickets[i];
           if(ticket.valueItem == result) {
               ticket.buyer.transfer(uint (totalReward));
           }
       }
   }
}
