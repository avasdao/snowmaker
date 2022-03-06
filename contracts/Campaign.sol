/*******************************************************************************
 *
 * SNOWMAKER - AVALANCHE PEER-TO-PEER CROWDFUNDING
 * __________________________________________________
 *
 * https://snowmaker.io
 *
 * Current version: v22.3.5
 *
 * Individual supporters can now easily send financial support to their
 * favorite crypto-accepting campaign(s).
 *
 * This platform is 100% decentralized and can run over ANY IPFS node using
 * exclusively client-side JavaScript (NO central server or APIs required).
 *
 * __________________________________________________
 *
 * Copyright (c) 2022 Ava's DAO
 *
 * SPDX-License-Identifier: MIT
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

pragma solidity ^0.8.0;

/*******************************************************************************
 *
 * Campaign Contract
 * __________________________________________________
 *
 * This contract controls the campaign's individual details.
 *
 */
contract Campaign {
    /* Enumerate the state of the campaign. */
    enum State {
        Fundraising,
        Expired,
        Successful
    }

    /* Define contributor pledge model. */
    struct Pledge {
        uint amount;
        string label;
        string comment;
        string url;
        uint timestamp;
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

    /* Initialize starting block. */
    uint private _startingBlock;

    /* Initialize starting time. */
    uint private _startingTime;

    /* Initialize pledges holder. */
    mapping (address => Pledge) private _pledges;

    /* Initialize total (campaign) pledges. */
    uint private _pledgeBalance;

    /* Initialize (campaign) state. */
    State private _state = State.Fundraising;

    /* Stretch goals. */
    // TODO: Coming soon
    address[] private _stretchGoals;

    /* Emitted after campaign creator has received the funds. */
    event CreatorPaid(
        address recipient,
        uint timestamp
    );

    /* Emitted after feedback is sent. */
    event FeedbackSent(
        address indexed supporter,
        string comment,
        uint timestamp
    );

    /* Emitted after pledge is received. */
    event PledgeReceived(
        address indexed contributor,
        uint pledgeAmount,
        uint totalPledgeAmount,
        string label,
        string comment,
        string url,
        uint bchUsd,
        uint fundsRaised,
        uint timestamp
    );

    /* Emitted after pledge is reclaimed. */
    event PledgeReclaimed(
        address indexed contributor,
        uint reclaimAmount,
        uint fundsRaised,
        uint timestamp
    );

    /* Emitted after report card is added. */
    event ReportCardAdded(
        address indexed publisher,
        string title,
        string url,
        uint timestamp
    );

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
    ) {
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

        /* Set starting block number. */
        // NOTE: We should make this configurable.
        _startingBlock = block.number;

        /* Set starting time. */
        // NOTE: We should make this configurable.
        _startingTime = block.timestamp;
    }

    /**
     * Make Pledge
     *
     * Fund a certain campaign.
     *
     * Application is required to provide the current BCH/USD spot price.
     * This value is added to the event log and used for historical pricing display.
     *
     * NOTE: Requires the current state to be "Fundraising".
     */
    function makePledge(
        string calldata _label,
        string calldata _comment,
        string calldata _url,
        uint _avaxUsd
    ) external inState(State.Fundraising) payable {
        /* Validate the contributor is NOT the creator. */
        require(msg.sender != _creator);

        /* Initialize a new pledge. */
        Pledge memory pledge;

        /* Initialize total pledge amount. */
        // NOTE: Contributors may increase their pledge amount at anytime.
        uint256 totalPledged;

        /* Validate outstanding pledge from contributor. */
        if (_pledges[msg.sender].amount > 0) {
            /* Calculate (accumulated) pledge total. */
            totalPledged = _pledges[msg.sender].amount + msg.value;
        } else {
            /* Set initial pledge total. */
            totalPledged = msg.value;
        }

        /* Set pledge amount. */
        pledge.amount = totalPledged;

        /* Set pledge label. */
        pledge.label = _label;

        /* Set pledge comment. */
        pledge.comment = _comment;

        /* Set pledge url. */
        pledge.url = _url;

        /* Set pledge timestamp. */
        pledge.timestamp = block.timestamp;

        /* Save pledge to contributor. */
        _pledges[msg.sender] = pledge;

        /* Add contribution to pledge balance. */
        _pledgeBalance = _pledgeBalance + msg.value;

        /* Send pledge notification. */
        emit PledgeReceived(
            msg.sender,
            msg.value,
            totalPledged,
            _label,
            _comment,
            _url,
            _avaxUsd,
            _pledgeBalance,
            block.timestamp
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
        } else if (block.timestamp > _expiration)  {
            _state = State.Expired;
        }

        /* Set completion time. */
        _completeAt = block.timestamp;
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
            emit CreatorPaid(
                _creator,
                block.timestamp
            );

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
     * Reclaim
     *
     * Return the total pledge amount to a contributor.
     *
     * NOTE: This function can only be called after a campaign has expired.
     *       THIS RESTRICTION HAS BEEN REMOVED FOR DEVELOPMENT PURPOSES ONLY
     */
    // function reclaim() external inState(State.Expired) returns (bool) {
    function reclaim() external returns (bool) {
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
        if (!payable(msg.sender).send(amountToRefund)) {
            /* Reset contribution total. */
            _pledges[msg.sender].amount = amountToRefund;

            /* Return false. */
            return false;
        } else {
            /* Adjust current balance. */
            _pledgeBalance = _pledgeBalance - amountToRefund;
        }

        /* Send reclaim notification. */
        emit PledgeReclaimed(
            msg.sender,
            amountToRefund,
            _pledgeBalance,
            block.timestamp
        );

        /* Return true. */
        return true;
    }

    /**
     * Get Campaign
     *
     * Retrieve details about a campaign.
     */
    function getCampaign() external view returns (
        address payable creator,
        string memory title,
        string memory description,
        uint256 startingBlock,
        uint256 startingTime,
        uint256 expiration,
        uint256 fundingGoal,
        State currentState,
        uint256 pledgeBalance
    ) {
        /* Set creator. */
        creator = _creator;

        /* Set title. */
        title = _title;

        /* Set description. */
        description = _description;

        /* Set starting block. */
        startingBlock = _startingBlock;

        /* Set starting time. */
        startingTime = _startingTime;

        /* Set expiration. */
        expiration = _expiration;

        /* Set funding goal. */
        fundingGoal = _fundingGoal;

        /* Set current state. */
        currentState = _state;

        /* Set pledge balance. */
        pledgeBalance = _pledgeBalance;
    }

    /**
     * Get Contributor
     *
     * Retrieve details about a contributor.
     */
    function getContributor(
        address _contributor
    ) external view returns (
        uint256 amount,
        string memory label,
        string memory comment,
        string memory url
    ) {
        /* Set amount. */
        amount = _pledges[_contributor].amount;

        /* Set label. */
        label = _pledges[_contributor].label;

        /* Set comment. */
        comment = _pledges[_contributor].comment;

        /* Set URL. */
        url = _pledges[_contributor].url;
    }

    /**
     * Send Feedback
     *
     * Allows ANYONE to leave feedback about the campaign.
     *
     * NOTE: Gas fees must still be paid.
     */
    function sendFeedback(
        string calldata _comment
    ) external returns (bool success) {
        /* Send feedback notification. */
        emit FeedbackSent(
            msg.sender,
            _comment,
            block.timestamp
        );

        /* Set success. */
        success = true;
    }

    /**
     * Add Report Card
     *
     * Allows a report card to be added to the campaign.
     *
     * NOTE: This specification is still under development.
     */
    function addReportCard(
        string calldata _reportTitle,
        string calldata _reportUrl
    ) external returns (bool success) {
        /* Send report card notification. */
        emit ReportCardAdded(
            msg.sender,
            _reportTitle,
            _reportUrl,
            block.timestamp
        );

        /* Set success. */
        success = true;
    }

}


/*******************************************************************************
 *
 * ( this contract was last updated on 2022.3.5 )
 *
 * Please visit our websites:
 *   - https://snowmaker.io
 *   - https://avasdao.org
 *
 * Don't hesitate to reach out to our team for support:
 *   - support@avasdao.org
 *   - avasdao.slack.com
 *
 * Chceck out these useful links:
 *   - https://docs.snowmaker.io
 *
 * We greatly appreciate ANY support for those that can offer it to our donation
 * address: xxx
 *
 */
