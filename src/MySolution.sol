
import {IEvaluator} from "./IEvaluator.sol";
import {RewardToken} from "./RewardToken.sol";

import {IQuoter} from "../node_modules/@uniswap/v3-periphery/contracts/interfaces/IQuoter.sol";

import {MyERC20} from "./MyERC20.sol";
import {MyERC721} from "./MyERC721.sol";

contract MySolution {

    //Instantiate the Evaluator contract
    IEvaluator public evaluator;
    RewardToken public rewardToken;

    //Instantiate my ERC20 contract
    MyERC20 public LucasToken;
    MyERC721 public LucasNFT;

    //Instantiate UniswapV3 contract
    IQuoter public quoter;


    constructor(address _evaluatorAddress, address _rewardTokenAddress, address _myTokenAddress, address _myErc721address) payable{

        evaluator = IEvaluator(_evaluatorAddress);
        rewardToken = RewardToken(_rewardTokenAddress);

        LucasToken = MyERC20(_myTokenAddress);
        LucasNFT = MyERC721(_myErc721address);

        // quoter = IQuoter(_quoterAddress);
    }


    function all_exercises() public{
        setSolutions();
        ex2();
        ex3();
        ex4_prep();
        ex4();
        ex5_prep();
        ex5();
        ex8();
        ex9();
    }

    function setSolutions() public {
        //Set the ERC20 token address in the Evaluator
        evaluator.registerStudentToken(address(LucasToken));
        //Set the ERC721 token address in the Evaluator
        evaluator.registerStudentNft(address(LucasNFT));
    }

    function ex2() public{
        LucasToken.approveAdmin(address(evaluator), 10000000);
        evaluator.ex2_mintStudentToken();
    }

    function ex3() public{
        LucasToken.approveAdmin(address(evaluator), 20000000);
        LucasToken.giveTokens(address(evaluator), 20000000);
        evaluator.ex3_mintEvaluatorToken();
    }

    function ex4_prep() public{
        evaluator.approve(address(LucasToken), 8000000000000000000);
        evaluator.transfer(address(LucasToken), 8000000000000000000);
        LucasToken.SwapRewardToken(msg.sender, 5000000000000000000);
    }

    function ex4() public{
        evaluator.ex4_checkRewardTokenBalance();
    }

    function ex5_prep() public{
        evaluator.approve(address(LucasToken), 14000000000000000000);
        evaluator.transfer(address(LucasToken), 14000000000000000000);
        LucasToken.SwapRewardToken(msg.sender, 10000000000000000000);
    }

    function ex5() public{
        rewardToken.approve(address(evaluator), 10000000000000000000);
        evaluator.ex5_checkRewardTokenBalance();
    }

    function ex8() public{
        evaluator.ex8_mintNFT();
    }

    function ex9() public{
        evaluator.ex9_burnNft();
    }

    function ex11() public{
        evaluator.ex11_unlock_ethers();
    }

    function deposit() external payable{
        require(msg.value > 0, "Zero ether not allowed");
    }
}