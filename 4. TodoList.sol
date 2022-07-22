//Deployed on : 

/* This smart contract lets the deployer(owner) to create his/her own TodoList.
  - Only Owner has the access to add the Todo
  - Only Owner has the access to mark the Todo to be Completed
  - Any user can view the todos of the owner
*/



//SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract ToDoList{
    struct Task{
        string text;
        uint id;
        bool completeToDo;
    }

    // array to store all the todos
    Task[] private todos;
    mapping(uint => address) todoToOwner;

    address public owner;

    event AddTodo(address sender, uint taskId);
    event CompletedToDo(uint todoId);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(owner == msg.sender, "Only owner has access!");
        _;
    }

    // this function creates a todo and adds into the array
    function addTodo(string calldata text) external onlyOwner{
        uint taskId = todos.length;
        todos.push(Task(text, taskId, false));
        todoToOwner[taskId] = msg.sender;
        emit AddTodo(msg.sender, taskId);
    }

  // returns all the todos
    function getMyToDos() external view returns(Task[] memory){
        Task[] memory temporaryTasks = new Task[](todos.length);
        uint count = 0;
        for(uint i = 0; i < todos.length; i++){
            if(todos[i].completeToDo == false){
                temporaryTasks[count] = todos[i];
                count++;
            }
        }
        Task[] memory result = new Task[](count);
        for(uint i = 0; i < count; i++)
            result[i] = temporaryTasks[i];
            return result;
    }
    
    //returns a todo at a given index
    function getMyTodo(uint index) external view returns(string memory todo){
        require(index >= 1, "Oops! index should be greater than 0");
        return todos[index-1].text;
    }

    //marks a todo complete
    function completeTodo(uint index) external onlyOwner{
        require(index >= 1, "Oops! index should be greater than 0");
        todos[index-1].completeToDo = true;
        emit CompletedToDo(index-1);
    }
   
}
