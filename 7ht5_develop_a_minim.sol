pragma solidity ^0.8.0;

contract MinimalistChatbotController {
    struct Conversation {
        address user;
        string[] messages;
        uint256 timestamp;
    }

    struct Response {
        string text;
        bool isFinal;
    }

    mapping(address => Conversation) public conversations;
    mapping(string => Response) public responses;

    event NewMessage(address user, string message);
    event Responded(address user, string response);

    function sendMessage(address _user, string memory _message) public {
        Conversation storage conversation = conversations[_user];
        conversation.messages.push(_message);
        conversation.timestamp = block.timestamp;
        emit NewMessage(_user, _message);
    }

    function getResponse(string memory _message) public view returns (Response memory) {
        return responses[_message];
    }

    function setResponse(string memory _message, string memory _response, bool _isFinal) public {
        responses[_message] = Response(_response, _isFinal);
    }

    function getConversation(address _user) public view returns (Conversation memory) {
        return conversations[_user];
    }
}