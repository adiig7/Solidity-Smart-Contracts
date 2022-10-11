// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;


interface IUniswapV2Router {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}

contract TestUniswap {
    address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function swap(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOut,
        address _to
    ) external {
        IERC20.transferFrom(msg.sender, address(this),_amountIn);
        IERC20.approve(UNISWAP_V2_ROUTER, _amountIn);

        address[] memory path;        
        if(_tokenIn == WETH || _tokenOut == WETH){
            path = new address[](3);
            path[0] = _tokenIn;
            path[1] = _tokenOut;
        }else{
            path = new address[](3);
            path[0] = _tokenIn;
            path[1] = WETH;
            path[2] = _tokenOut;
        }
       
        IUniswapV2Router(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
        _amountIn,
        _amountOut,
        path,
        msg.sender,
        block.timestamp
    );
    }

    function getAmountOut(address _tokenIn, address _tokenOut, uint256 _amount) external view returns(uint256){
        address[] memory path;
            if (_tokenIn == WETH || _tokenOut == WETH) {
            path = new address[](2);
            path[0] = _tokenIn;
            path[1] = _tokenOut;
            } else {
            path = new address[](3);
            path[0] = _tokenIn;
            path[1] = WETH;
            path[2] = _tokenOut;
            }
            uint[] memory amounts = IUniswapV2Router(UNISWAP_V2_ROUTER).getAmountsOut(_amountIn, path);
            return amounts[path.length-1];
    } 
}
