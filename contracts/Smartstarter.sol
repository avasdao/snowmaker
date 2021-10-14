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
 * favorite crypto-accepting project(s).
 *
 * This platform is 100% decentralized and can run over ANY IPFS node using
 * exclusively client-side JavaScript (NO central server or APIs).
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

/* Initialize Solidity version 0.5.4 */
pragma solidity 0.5.4;

/* Import OpenZeppelin's SafeMath implementation. */
import 'https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol';


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
    Campiagn[] private campaigns;

    /* Event that will be emitted whenever a new campaign is started. */
    event CampaignStarted(
        address contractAddress,
        address projectStarter,
        string projectTitle,
        string projectDesc,
        uint256 expiration,
        uint256 goalAmount
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
    function startProject(
        string calldata title,
        string calldata description,
        uint durationInDays,
        uint amountToRaise
    ) external {
        uint raiseUntil = now.add(durationInDays.mul(1 days));

        Project newProject = new Project(
            msg.sender, title, description, raiseUntil, amountToRaise);

        projects.push(newProject);

        emit ProjectStarted(
            address(newProject),
            msg.sender,
            title,
            description,
            raiseUntil,
            amountToRaise
        );
    }

    /**
     * Return All Projects
     *
     * Function to get all projects' contract addresses.
     *
     * Will return a list of all projects' contract addreses.
     */
    function returnAllProjects() external view returns(Project[] memory){
        return projects;
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

    // Data structures
    enum State {
        Fundraising,
        Expired,
        Successful
    }

    // State variables
    address payable public creator;
    uint public amountGoal; // required to reach at least this much, else everyone gets refund
    uint public completeAt;
    uint256 public currentBalance;
    uint public raiseBy;
    string public title;
    string public description;
    State public state = State.Fundraising; // initialize on create
    mapping (address => uint) public contributions;

    // Event that will be emitted whenever funding will be received
    event FundingReceived(address contributor, uint amount, uint currentTotal);

    // Event that will be emitted whenever the project starter has received the funds
    event CreatorPaid(address recipient);

    // Modifier to check current state
    modifier inState(State _state) {
        require(state == _state);
        _;
    }

    // Modifier to check if the function caller is the project creator
    modifier isCreator() {
        require(msg.sender == creator);
        _;
    }

    /* Constructor. */
    constructor (
        address payable projectStarter,
        string memory projectTitle,
        string memory projectDesc,
        uint fundRaisingDeadline,
        uint goalAmount
    ) public {
        creator = projectStarter;
        title = projectTitle;
        description = projectDesc;
        amountGoal = goalAmount;
        raiseBy = fundRaisingDeadline;
        currentBalance = 0;
    }

    /**
     * Contribute
     *
     * Function to fund a certain project.
     *
     * NOTE: Requires the current state to be "Fundraising".
     */
    function contribute() external inState(State.Fundraising) payable {
        require(msg.sender != creator);

        contributions[msg.sender] = contributions[msg.sender]
            .add(msg.value);

        currentBalance = currentBalance.add(msg.value);

        emit FundingReceived(msg.sender, msg.value, currentBalance);

        checkIfFundingCompleteOrExpired();
    }

    /**
     * Check If Funding Complete or Expired
     *
     * Function to change the project state depending on conditions.
     */
    function checkIfFundingCompleteOrExpired() public {
        /* Validate current balance. */
        if (currentBalance >= amountGoal) {
            /* Set state to "Successful". */
            state = State.Successful;

            /* Make payout. */
            // NOTE: The payout address MUST be an "external" account (NOT a contract).
            payOut();
        } else if (now > raiseBy)  {
            state = State.Expired;
        }

        /* Set completion time. */
        completeAt = now;
    }

    /**
     * Payout
     *
     * Function to give the received funds to project starter.
     */
    function payOut() internal inState(State.Successful) returns (bool) {
        /* Set total raised. */
        uint256 totalRaised = currentBalance;

        /* Reset current balance. */
        currentBalance = 0;

        /* Send total raised to creator. */
        if (creator.send(totalRaised)) {
            /* Emit event. */
            emit CreatorPaid(creator);

            /* Return true. */
            return true;
        } else {
            /* Reset current balance. */
            currentBalance = totalRaised;

            /* Reset state. */
            state = State.Successful;
        }

        /* Return false. */
        return false;
    }

    /**
     * Get Refund
     *
     * Function to retrieve donated amount when a project expires.
     */
    function getRefund() public inState(State.Expired) returns (bool) {
        /* Validate contribution balance. */
        require(contributions[msg.sender] > 0);

        /* Set amount to refund. */
        uint amountToRefund = contributions[msg.sender];

        /* Set contribution amount to zero. */
        // NOTE: This is required to block re-entry attack.
        // TODO: Allow partial refund requests.
        contributions[msg.sender] = 0;

        /* Send refund. */
        if (!msg.sender.send(amountToRefund)) {
            /* Reset contribution total. */
            contributions[msg.sender] = amountToRefund;

            /* Return false. */
            return false;
        } else {
            /* Reset current balance. */
            currentBalance = currentBalance.sub(amountToRefund);
        }

        /* Return true. */
        return true;
    }

    /**
     * Get Details
     *
     * Function to get specific information about the project.
     *
     * @return Returns all the project's details
     */
    function getDetails() public view returns (
        address payable projectStarter,
        string memory projectTitle,
        string memory projectDesc,
        uint256 deadline,
        State currentState,
        uint256 currentAmount,
        uint256 goalAmount
    ) {
        projectStarter = creator;
        projectTitle = title;
        projectDesc = description;
        deadline = raiseBy;
        currentState = state;
        currentAmount = currentBalance;
        goalAmount = amountGoal;
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
