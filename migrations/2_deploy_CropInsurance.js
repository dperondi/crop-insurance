const CropInsurance = artifacts.require("CropInsurance");
const GIF_PRODUCT_SERVICE_CONTRACT ="0x6520354fa128cc6483B9662548A597f7FcB7a687";
module.exports = deployer => deployer.deploy(CropInsurance, GIF_PRODUCT_SERVICE_CONTRACT);
