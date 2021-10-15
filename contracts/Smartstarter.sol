/*******************************************************************************
 *
 * SMARTSTARTER - SMART BITCOIN CROWDFUNDING
 * __________________________________________________
 *
 * https://smartstarter.cash
 *
 * Current version: v21.10.14
 *
 * Individual supporters can now easily send financial support to their
 * favorite crypto-accepting campaign(s).
 *
 * This platform is 100% decentralized and can run over ANY IPFS node using
 * exclusively client-side JavaScript (NO central server or APIs required).
 *
 * __________________________________________________
 *
 * Copyright (c) 2021 Bitcoin Please
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

pragma solidity 0.5.17;

/*******************************************************************************
 *
 * SafeMath
 */
library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}


/*******************************************************************************
 *
 * Smartstarter Contract
 * __________________________________________________
 *
 * This is the platform's primary contract.
 *
 * This contract will manage the campaigns created on the platform.
 *
 */
contract Smartstarter {
    using SafeMath for uint256;

    /* Initialize campaigns holder. */
    Campaign[] private _campaigns;

    /* Event that will be emitted whenever a new campaign is started. */
    event CampaignStarted(
        address campaignAddress,
        address campaignCreator,
        string campaignTitle,
        string campaignDesc,
        uint256 fundingGoal,
        uint256 expiration
    );

    /**
     * Start Campaign
     *
     * Create a new campaign in Smartstarter.
     *
     * Params:
     *   - title: Title of the campaign to be created
     *   - pitch: Brief explanation about the campiagn
     *   - description: Detailed explaination about the campaign
     *   - durationInDays: Project deadline in days (optional, 0 = no expiration)
     *   - amountToRaise: Project goal in wei(?)
     */
    function startCampaign(
        string calldata _title,
        string calldata _description,
        uint _durationInDays,
        uint _amountToRaise
    ) external {
        /* Set expiration date. */
        uint expiration = now.add(_durationInDays.mul(1 days));

        /* Initialize a new campaign. */
        Campaign newCampaign = new Campaign(
            msg.sender,
            _title,
            _description,
            _amountToRaise,
            expiration
        );

        /* Add new campaign. */
        _campaigns.push(newCampaign);

        /* Send notification. */
        emit CampaignStarted(
            address(newCampaign),
            msg.sender,
            _title,
            _description,
            _amountToRaise,
            expiration
        );
    }

    /**
     * Request All Campaigns
     *
     * Returns the contract addresses for ALL campaigns.
     */
    function getCampaigns() external view returns(Campaign[] memory){
        return _campaigns;
    }
}


/*******************************************************************************
 *
 * Campaign Contract
 * __________________________________________________
 *
 * This contract controls the campaign's individual details.
 *
 */
contract Campaign {
    using SafeMath for uint256;

    /* Enumerate the state of the campaign. */
    enum State {
        Fundraising,
        Expired,
        Successful
    }

    /* Enumerate the state of the campaign. */
    struct Pledge {
        uint amount;
        string label;
        string comment;
        string url;
    }

    /* Initialize creator. */
    address payable private _creator;

    /* Initialize title. */
    string private _title;

    /* Initialize description. */
    string private _description;

    /* Initialize funding goal. */
    // NOTE: Required to reach at least this much, else everyone gets refund.
    uint private _fundingGoal;

    /* Initialize expiration date. */
    uint private _expiration;

    /* Initialize completion date. */
    uint private _completeAt;

    /* Initialize pledges holder. */
    mapping (address => Pledge) private _pledges;

    /* Initialize total (campaign) pledges. */
    uint256 private _pledgeBalance;

    /* Initialize (campaign) state. */
    State private _state = State.Fundraising;

    /* Emitted after pledge is received. */
    event PledgeReceived(
        address contributor,
        uint pledgeAmount,
        uint fundsRaised
    );

    /* Emitted after campaign creator has received the funds. */
    event CreatorPaid(address recipient);

    /* Validate current state. */
    modifier inState(State _s) {
        require(_state == _s);
        _;
    }

    /* Validate caller is the campaign creator. */
    modifier isCreator() {
        require(msg.sender == _creator);
        _;
    }

    /* Constructor. */
    constructor (
        address payable _campaignCreator,
        string memory _campaignTitle,
        string memory _campaignDesc,
        uint _campaignFundingGoal,
        uint _campaignExpiration
    ) public {
        /* Set campaign creator. */
        _creator = _campaignCreator;

        /* Set title. */
        _title = _campaignTitle;

        /* Set description. */
        _description = _campaignDesc;

        /* Set funding goal. */
        _fundingGoal = _campaignFundingGoal;

        /* Set expiration. */
        _expiration = _campaignExpiration;

        /* Set total pledged balance. */
        _pledgeBalance = 0;
    }

    /**
     * Make Pledge
     *
     * Fund a certain campaign.
     *
     * NOTE: Requires the current state to be "Fundraising".
     */
    function makePledge(
        string calldata _label,
        string calldata _comment,
        string calldata _url
    ) external inState(State.Fundraising) payable {
        /* Validate the contributor is NOT the creator. */
        require(msg.sender != _creator);

        /* Initialize a new pledge. */
        Pledge memory pledge;

        /* Validate outstanding pledge from contributor. */
        if (_pledges[msg.sender].amount > 0) {
            /* Calculate new (pledge) total. */
            uint256 newTotal = _pledges[msg.sender].amount.add(msg.value);

            /* Set the new total. */
            pledge.amount = newTotal;
        } else {
            /* Initialize a zero amount. */
            pledge.amount = 0;
        }

        /* Set pledge label. */
        pledge.label = _label;

        /* Set pledge comment. */
        pledge.comment = _comment;

        /* Set pledge url. */
        pledge.url = _url;

        /* Save pledge to contributor. */
        _pledges[msg.sender] = pledge;

        /* Add contribution to pledge balance. */
        _pledgeBalance = _pledgeBalance.add(msg.value);

        /* Send pledge notification. */
        emit PledgeReceived(
            msg.sender,
            msg.value,
            _pledgeBalance
        );

        /* Validate campaign completion / expiration. */
        checkIfFundingCompleteOrExpired();
    }

    /**
     * Check If Funding Complete or Expired
     *
     * Change the campaign state depending on conditions.
     */
    function checkIfFundingCompleteOrExpired() public {
        /* Validate current balance. */
        if (_pledgeBalance >= _fundingGoal) {
            /* Set state to "Successful". */
            _state = State.Successful;

            /* Make payout. */
            // NOTE: The payout address MUST be an "external" account (NOT a contract).
            payout();
        } else if (now > _expiration)  {
            _state = State.Expired;
        }

        /* Set completion time. */
        _completeAt = now;
    }

    /**
     * Payout
     *
     * Deliver received pledges to campaign creator.
     */
    function payout() internal inState(State.Successful) returns (bool) {
        /* Set total raised. */
        uint256 totalRaised = _pledgeBalance;

        /* Reset current balance. */
        _pledgeBalance = 0;

        /* Send total raised to creator. */
        if (_creator.send(totalRaised)) {
            /* Emit event. */
            emit CreatorPaid(_creator);

            /* Return true. */
            return true;
        } else {
            /* Reset current balance. */
            _pledgeBalance = totalRaised;

            /* Reset state. */
            _state = State.Successful;
        }

        /* Return false. */
        return false;
    }

    /**
     * Get Refund
     *
     * Return pledged amount after a campaign expires.
     */
    function getRefund() public inState(State.Expired) returns (bool) {
        /* Validate contribution balance. */
        require(_pledges[msg.sender].amount > 0);

        /* Set amount to refund. */
        uint amountToRefund = _pledges[msg.sender].amount;

        /* Set contribution amount to zero. */
        // NOTE: This is required to block re-entry attack.
        //       (https://docs.soliditylang.org/en/v0.5.3/security-considerations.html#re-entrancy)
        // TODO: Allow partial refund requests.
        _pledges[msg.sender].amount = 0;

        /* Send refund. */
        if (!msg.sender.send(amountToRefund)) {
            /* Reset contribution total. */
            _pledges[msg.sender].amount = amountToRefund;

            /* Return false. */
            return false;
        } else {
            /* Adjust current balance. */
            _pledgeBalance = _pledgeBalance.sub(amountToRefund);
        }

        /* Return true. */
        return true;
    }

    /**
     * Get Details
     *
     * Retrieve details about a campaign.
     */
    function getDetails() public view returns (
        address payable campaign,
        string memory campaignTitle,
        string memory campaignDesc,
        uint256 expiration,
        uint256 fundingGoal,
        State currentState,
        uint256 pledgeBalance
    ) {
        campaign = _creator;
        campaignTitle = _title;
        campaignDesc = _description;
        expiration = _expiration;
        fundingGoal = _fundingGoal;
        currentState = _state;
        pledgeBalance = _pledgeBalance;
    }
}


/*******************************************************************************
 *
 * ( this contract was last updated on 2021.10.14 )
 *
 * Please visit our websites:
 *   - https://smartstarter.cash
 *   - https://bchplease.org
 *
 * Don't hesitate to reach out to our team for support:
 *   - support@bchplease.org
 *   - bchplease.slack.com
 *
 * Chceck out these useful links:
 *   - https://docs.smartstarter.cash
 *   - https://flipstarter.cash
 *
 * We greatly appreciate ANY support for those that can offer it. For your
 * convenience, we accept many forms of crypto donations:
 *
 *   - Donate BCH     bitcoincash:qqvl7fwcthhhntsew056t8007pw55k258vmlm053fy
 *   - Donate SLP     simpleledger:qqxtz0fw3gs5ndmwjm2we92k20zu3z99uuuxr25a2s
 *   - Donate sBCH    << hardware wallet support is currently in development >>
 *
 */
