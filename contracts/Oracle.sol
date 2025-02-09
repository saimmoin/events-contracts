// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@uniswap/v2-periphery/contracts/libraries/UniswapV2OracleLibrary.sol";
import "./FullMath.sol";
import "./IOracle.sol";
interface IERC20 {
    function decimals() external view returns (uint8);
}
contract Oracle is IOracle {
    using FixedPoint for *;

    address public constant ALPHA = 0x2E224d6f7C1858cf9572393bd1f29917d8A604c0;
    address public constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7; // HONEY stable coin

    address public constant UNISWAP_V2_FACTORY = 0xB7f907f7A9eBC822a80BD25E224be42Ce0A698A0;

    IUniswapV2Factory factoryInterface;
    mapping(address => uint256) public commulativeAveragePrice;
    mapping(address => uint256) public commulativeETHPrice;
    mapping(address => uint32) public tokenToTimestampLast;
    mapping(address => uint256) public commulativeAveragePriceReserve;
    mapping(address => uint256) public commulativeETHPriceReserve;
    mapping(address => uint32) public lastTokenTimestamp;

    event AssetValue(uint256, uint256);

    constructor() {
        factoryInterface = IUniswapV2Factory(UNISWAP_V2_FACTORY);
        //setValues(USDT);
    }

    function setV2FactoryAddress(address _factory) external {
        factoryInterface = IUniswapV2Factory(_factory);
    }

    function setValues(address token) public {
        address pool = factoryInterface.getPair(WETH, token);
        if (pool != address(0)) {
            if (WETH < token) {
                (
                    commulativeETHPrice[token],
                    commulativeAveragePrice[token],
                    tokenToTimestampLast[token]
                ) = UniswapV2OracleLibrary.currentCumulativePrices(
                    address(pool)
                );
            } else {
                (
                    commulativeAveragePrice[token],
                    commulativeETHPrice[token],
                    tokenToTimestampLast[token]
                ) = UniswapV2OracleLibrary.currentCumulativePrices(
                    address(pool)
                );
            }

            lastTokenTimestamp[token] = uint32(block.timestamp);
        }
    }

    function fetch(address token) external override returns (uint256 price) {
        if (token == USDT || token == USDC) {
            return 1.000000;
        }

        if (
            commulativeAveragePrice[token] == 0 ||
            ((uint256(block.timestamp) - uint256(lastTokenTimestamp[token]))) >=
            1 minutes
        ) {
            setValues(token);
        }

        uint256 ethPerUSDT = _getAmount(USDT);
        emit AssetValue(ethPerUSDT, block.timestamp);

        if (token == WETH) {
            price = ethPerUSDT;
            emit AssetValue(ethPerUSDT, block.timestamp);
            emit AssetValue(price, block.timestamp);
            return price;
        } else {
            uint256 ethPerToken = _getAmount(token);
            emit AssetValue(ethPerToken, block.timestamp);
            if (ethPerToken == 0 || ethPerUSDT == 0) {
                return 0;
            }
            uint8 decimals = IERC20(token).decimals();
            price = (ethPerUSDT * (10 ** decimals)) / ethPerToken;
            emit AssetValue(price, block.timestamp);
            return price;
        }
    }

    function fetchAlphaPrice() external override returns (uint256 price) {
        if (
            commulativeAveragePrice[ALPHA] == 0 ||
            ((uint256(block.timestamp) - uint256(lastTokenTimestamp[ALPHA]))) >=
            3 minutes
        ) {
            setValues(ALPHA);
        }

        uint32 timeElapsed = uint32(
            (uint256(lastTokenTimestamp[ALPHA]) -
                uint256(tokenToTimestampLast[ALPHA]))
        );

        price = _calculate(
            commulativeETHPrice[ALPHA],
            commulativeAveragePrice[ALPHA],
            timeElapsed,
            ALPHA
        );
        emit AssetValue(price, block.timestamp);
    }

    function _getAmount(
        address token
    ) internal view returns (uint256 ethPerToken) {
        address poolAddress = factoryInterface.getPair(WETH, token);
        if (poolAddress == address(0)) {
            return 0;
        }

        uint256 timeElapsed = uint256(lastTokenTimestamp[token]) -
            uint256(tokenToTimestampLast[token]);

        ethPerToken = _calculate(
            commulativeETHPriceReserve[token],
            commulativeAveragePriceReserve[token],
            timeElapsed,
            token
        );
    }

    function _calculate(
        uint256 latestCumulativePrice,
        uint256 oldCumulativePrice,
        uint256 timeElapsed,
        address token
    ) public view returns (uint256 assetValue) {
        FixedPoint.uq112x112 memory priceTemp = FixedPoint.uq112x112(
            uint224((latestCumulativePrice - oldCumulativePrice) / timeElapsed)
        );
        uint256 decimals = IERC20(token).decimals();
        assetValue = priceTemp.mul(10 ** decimals).decode144();
    }
}
