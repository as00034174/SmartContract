contract Buyticket {
    uint public amount;
    address public owner;
    uint public totalReward;
    uint8 public result;
    Ticket public winner;
    struct Ticket {
        address buyer;
        uint valueItem;
    }
    
    Ticket[] public tickets;
    
    
    constructor (uint _quantity) {
        owner = msg.sender;
        amount = _quantity;
        
    }
    
    // mapping(address => uint) public tickets;
    function BuyOneTicket() public payable {
        require(amount > 0);
        require(msg.value == 0.1 ether);
        for(uint8 z = 0 ; z < tickets.length ; z++)
        require(tickets[z].buyer != msg.sender );
        totalReward += msg.value;     
        tickets.push(Ticket (msg.sender, random()));
        amount --;
        
    }
    
    function GetResult() private {
        result = random(); 
    }
    
    function random() private view returns (uint8) {
       return uint8(uint256(keccak256(block.timestamp, block.difficulty))%100);
   }
   
   function sendRewardForWinner() public {
       require(msg.sender == owner);
       require(winner.buyer == 0 );
       GetResult();
       for(uint i = 0 ; i < tickets.length ; i++) {
           Ticket memory ticket = tickets[i];
           if(ticket.valueItem == result) {
               ticket.buyer.transfer(uint (totalReward));
               winner = ticket;
           }
       }
       if(winner.buyer == 0)
       {
           winner.buyer = owner;
           owner.transfer(amount);
       }
   }
}
