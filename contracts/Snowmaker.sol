/*******************************************************************************
 *
 * SNOWMAKER - AVALANCE PEER-TO-PEER CROWDFUNDING
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

/* Import contracts. */
import './Campaign.sol';

/*******************************************************************************
 *
 * Snowmaker Contract
 * __________________________________________________
 *
 * This is the platform's primary contract.
 *
 * This contract will manage the campaigns created on the platform.
 *
 */
contract Snowmaker {
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
     * Create a new campaign in Snowmaker.
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
        uint expiration = block.timestamp + (_durationInDays * 1 days);

        /* Initialize a new campaign. */
        Campaign newCampaign = new Campaign(
            payable(msg.sender),
            _title,
            _description,
            _amountToRaise,
            expiration
        );

        /* Add new campaign. */
        // TODO: Save a copy to Eternal Database to support future upgrades.
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
