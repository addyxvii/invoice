pragma solidity >=0.7.0 <0.9.0;

// import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
// import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract Invoice {
    
    struct Bill {
        int invoiceNum;
        int amountUSD;
        bool paid;
    }
    
    // AggregatorV3Interface internal priceFeed;

    // ERC20 public USDC;
    // ERC20 public WETH;
    address payable public owner;
    Bill public invoice;

    modifier restricted() {
        require(msg.sender == owner);
        _;
    }
    
    constructor() {
        owner = payable(msg.sender); 
        
        // USDC = ERC20(0x07865c6E87B9F70255377e024ace6630C1Eaa37F);
        // WETH = ERC20(0xc778417E063141139Fce010982780140Aa0cD5Ab);
        
        // priceFeed = AggregatorV3Interface(0x64EaC61A2DFda2c3Fa04eED49AA33D021AeC8838);

    }
    
    //     function getThePrice() public view returns (int) {
    //     (
    //         uint80 roundID, 
    //         int price,
    //         uint startedAt,
    //         uint timeStamp,
    //         uint80 answeredInRound
    //     ) = priceFeed.latestRoundData();
    //     return price;
    // }
    
    function createBill(int invoiceNum, int amountUSD) public restricted {
        Bill storage newInvoice = invoice;
        newInvoice.invoiceNum = invoiceNum;
        newInvoice.amountUSD = amountUSD;
        newInvoice.paid = false;
    }
    
    function payBill(int invoiceNum) public payable {
        // int price = getThePrice();
        // int wethAmount = price/invoice.amountUSD;
        require(invoice.invoiceNum == invoiceNum);
        require(!invoice.paid);
        
        Bill storage updatedInvoice = invoice;
        updatedInvoice.paid = true;
        
        // address(WETH).call("transfer(owner,wethAmount)");
        // address(USDC).call("transfer(owner,invoice.amountUSD)");
        owner.transfer(address(this).balance);
        
    }

}