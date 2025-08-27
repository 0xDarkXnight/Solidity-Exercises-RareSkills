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
        (bool ok, bytes memory priceOracle1) = _priceOracle1.call(
            abi.encodeWithSignature("price()")
        );
        require(ok, "call failed!");
        uint256 priceOfOracle1;
        priceOfOracle1 = abi.decode(priceOracle1, (uint256));

        (bool okk, bytes memory priceOracle2) = _priceOracle2.call(
            abi.encodeWithSignature("price()")
        );
        require(okk, "call failed!");

        uint256 priceOfOracle2;
        priceOfOracle2 = abi.decode(priceOracle2, (uint256));

        if (priceOfOracle1 > priceOfOracle2) {
            return priceOfOracle2;
        }
        return priceOfOracle1;
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
