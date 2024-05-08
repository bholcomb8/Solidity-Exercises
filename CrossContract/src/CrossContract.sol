// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {
        (bool r1, bytes memory price1) = _priceOracle1.call(abi.encodeWithSignature("price()"));
        (bool r2, bytes memory price2) = _priceOracle2.call(abi.encodeWithSignature("price()"));
        
        require(r1, "call to priceOracle1 contract failed");
        require(r2, "call to priceOracle2 failed");

        uint256 p1 = abi.decode(price1, (uint256));
        uint256 p2 = abi.decode(price2, (uint256));

        if (p1 > p2) {
            return p2;
        } else {
            return p1;
        }
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
