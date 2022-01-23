// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Web3pedia {
    uint256 questionId;
    mapping(uint256 => uint256) answerIds;
    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastAsked;
    mapping(address => uint256) public lastAnswered;


    event NewQuestion(
        uint256 question_id, 
        uint256 timestamp, 
        address indexed from, 
        string question, 
        uint256 stake //in gwei
    );

    event NewAnswer(
        uint256 answer_id,
        uint256 question_id,
        uint256 timestamp, 
        address indexed from, 
        string answer
    );

    constructor() payable {
        console.log("We have been constructed!");
    }

    function ask(string memory _question) public {
       /*
         * We need to make sure the current timestamp is at least 30 seconds bigger than the last timestamp we stored
         */
        require(lastAsked[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");

        /*
         * Update the current timestamp we have for the user
         */
        lastAsked[msg.sender] = block.timestamp;

        questionId += 1;
        console.log("id: %d, time: %d, question: %s", questionId, block.timestamp, _question);
        console.log("sender", msg.sender);
        emit NewQuestion(questionId, block.timestamp, msg.sender, _question, 100000);
    }

    function answer(uint256 currentQuestionId, string memory _answer) public {
        /*
         * We need to make sure the current timestamp is at least 30 seconds bigger than the last timestamp we stored
         */
        require(lastAnswered[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");

        /*
         * Update the current timestamp we have for the user
         */
        lastAnswered[msg.sender] = block.timestamp;

        answerIds[currentQuestionId] += 1;
        console.log("questionId: %d, time: %d, answer: %s", currentQuestionId, block.timestamp, _answer);
        console.log("sender", msg.sender);
        console.log("answerId", answerIds[currentQuestionId]);
        emit NewAnswer(answerIds[currentQuestionId], currentQuestionId, block.timestamp, msg.sender, _answer);
    }
}