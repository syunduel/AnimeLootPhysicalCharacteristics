// SPDX-License-Identifier: GPL-3.0
    
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 
import "remix_accounts.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../contracts/AnimeLoot.sol";
import "../contracts/AnimeLootPhysicalCharacteristics.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

    AnimeLoot al;
    AnimeLootPhysicalCharacteristics alpc;

    // address acc0;
    // address acc1;
    // address acc2;
    
    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        // <instantiate contract>
        // acc0 = TestsAccounts.getAccount(0); 
        // acc1 = TestsAccounts.getAccount(1);
        // acc2 = TestsAccounts.getAccount(2);
        al = new AnimeLoot();
        alpc = new AnimeLootPhysicalCharacteristics(address(al));
    }
    
    function beforeEach() public {
    }
    
    function checkALPCTargetAddress() public {
        address targetAddress = alpc.getTargetContract();
        Assert.equal(targetAddress, address(al), "targetAddress should keep");
    }

    function checkCanNotClaimZero() public {

        try alpc.claim(0) {
            Assert.ok(false, 'method execution should fail');
        } catch Error(string memory reason) {
            // Compare failure reason, check if it is as expected
            Assert.equal(reason, 'ERC721: owner query for nonexistent token', 'failed with unexpected reason');
        } catch (bytes memory /*lowLevelData*/) {
            Assert.ok(false, 'failed unexpected');
        }
    }
    
    function checkCanClaimTargetTokenIdHolder1() public {

        al.claim(1);

        try alpc.claim(1) {
            Assert.ok(true, 'holder can claim');
        } catch Error(string memory reason) {
            // Compare failure reason, check if it is as expected
            Assert.ok(false, reason);
        } catch (bytes memory /*lowLevelData*/) {
            Assert.ok(false, 'failed unexpected');
        }
    }
    
    function checkCanClaimTargetTokenIdHolder7999() public {

        al.claim(7999);

        try alpc.claim(7999) {
            Assert.ok(true, 'holder can claim');
        } catch Error(string memory reason) {
            // Compare failure reason, check if it is as expected
            Assert.ok(false, 'throw error');
        } catch (bytes memory /*lowLevelData*/) {
            Assert.ok(false, 'failed unexpected');
        }
    }

    function checkSuccess() public {
        // Use 'Assert' methods: https://remix-ide.readthedocs.io/en/latest/assert_library.html
        Assert.ok(2 == 2, 'should be true');
        Assert.greaterThan(uint(2), uint(1), "2 should be greater than to 1");
        Assert.lesserThan(uint(2), uint(3), "2 should be lesser than to 3");
    }

    function checkSuccess2() public pure returns (bool) {
        // Use the return value (true or false) to test the contract
        return true;
    }
    
    function checkFailure() public {
        // Assert.notEqual(uint(1), uint(1), "1 should not be equal to 1");
    }

    /// Custom Transaction Context: https://remix-ide.readthedocs.io/en/latest/unittesting.html#customization
    /// #sender: account-1
    /// #value: 100
    function checkSenderAndValue() public payable {
        // account index varies 0-9, value is in wei
        Assert.equal(msg.sender, TestsAccounts.getAccount(1), "Invalid sender");
        Assert.equal(msg.value, 100, "Invalid value");
    }
}
