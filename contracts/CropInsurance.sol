pragma solidity 0.5.2;

import "@etherisc/gif/contracts/Product.sol";

contract CropInsurance is Product {

    event LogRequestUnderwriter(uint256 applicationId);
    event LogApplicationUnderwritten(uint256 applicationId, uint256 policyId);
    event LogApplicationDeclined(uint256 applicationId);
    event LogRequestClaimsManager(uint256 policyId, uint256 claimId);
    event LogClaimDeclined(uint256 claimId);
    event LogRequestPayout(uint256 payoutId);
    event LogPayout(uint256 claimId, uint256 amount);

    bytes32 public constant NAME = "CropInsurance";
    bytes32 public constant POLICY_FLOW = "PolicyFlowDefault";

    struct Risk {
        bytes32 crop;
        bytes32 wsid;
        uint256 year;
    }

    mapping(bytes32 => Risk) public risks;

    constructor(address _productService)
        public Product(_productService, NAME, POLICY_FLOW) {}

    function getQuote(uint256 _price) public pure returns (uint256 _premium) {
        require(_price > 0, "ERROR::INVALID PRICE");
        _premium = _price.div(10);
    }

    function applyForPolicy(
        bytes32 _crop,
        bytes32 _wsid,
        uint256 _year,
        uint256 _price,
        uint256 _premium,
        bytes32 _currency,
        bytes32 _bpExternalKey
    )external onlySandbox {
        require(_premium > 0, "ERROR:INVALID_PREMIUM");
        require(getQuote(_price) == _premium, "ERROR::INVALID_PREMIUM");

        bytes32 riskId = keccak256(abi.encodePacked(_crop, _wsid, _year));
        risks[riskId] = Risk(_crop, _wsid, _year);

        uint256[] memory payoutOptions = new uint256[](1);
        payoutOptions[0] = _price;

        uint256 applicationId = _newApplication(_bpExternalKey, _premium, _currency, payoutOptions);

        emit LogRequestUnderwriter(applicationId);
    }

    function underwriteApplication(uint256 _applicationId) external onlySandbox {
        uint256 policyId = _underwrite(_applicationId);
        emit LogApplicationUnderwritten(_applicationId, policyId);
    }

    function declineApplication(uint256 _applicationId) external onlySandbox {
        _decline(_applicationId);
        emit LogApplicationDeclined(_applicationId);
    }

    function createClaim(uint256 _policyId) external onlySandbox {
        uint256 claimId = _newClaim(_policyId);
        emit LogRequestClaimsManager(_policyId, claimId);
    }

    function confirmClaim(uint256 _applicationId, uint256 _claimId) external onlySandbox {
        uint256[] memory payoutOptions = _getPayoutOptions(_applicationId);
        uint256 payoutId = _confirmClaim(_claimId, payoutOptions[0]);
        emit LogRequestPayout(payoutId);
    }

    function confirmPayout(uint256 _claimId, uint256 _amount) external onlySandbox {
        _payout(_claimId, _amount);
        emit LogPayout(_claimId, _amount);
    }

}
