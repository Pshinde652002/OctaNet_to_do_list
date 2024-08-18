<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced To-Do List</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #4486f8, #7e2fd3);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Container */
        .container {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            width: 500px;
            text-align: center;
        }

        /* Heading */
        h1 {
            margin-bottom: 25px;
            color: #ffffff;
            font-size: 28px;
        }

        /* Input Group */
        .input-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
            gap: 15px;
        }

        #taskInput {
            width: 50%;
            padding: 15px;
            border: 2px solid #cccccc;
            border-radius: 8px;
            outline: none;
            font-size: 16px;
        }

        #taskTime {
            width: 45%;
            padding: 15px;
            border: 2px solid #cccccc;
            border-radius: 8px;
            outline: none;
            font-size: 16px;
        }

        #addTaskBtn {
            padding: 15px 25px;
            background-color: #29e62f;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        #addTaskBtn:hover {
            background-color: #2f46cc;
        }

        /* Task List */
        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            position: relative;
            cursor: pointer; /* Add cursor to indicate it's clickable */
        }

        li:hover {
            background-color: #f0f0f0;
            transform: translateY(-5px);
        }

        .completed {
            background-color: #e8f5e9;
            color: #45ae4a;
        }

        .completed::before {
            content: '✓'; /* Checkmark */
            position: absolute;
            padding-left: -20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 30px;
            color: #46b14b;
        }

        /* Task Controls */
        .task-controls {
            display: flex;
            gap: 10px;
        }

        button {
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button.deleteBtn {
            background-color: #f44336;
            color: white;
        }

        button.deleteBtn:hover {
            background-color: #c62828;
        }

        button.editBtn {
            background-color: #ff9800;
            color: white;
        }

        button.editBtn:hover {
            background-color: #f57c00;
        }

        .task-time {
            font-size: 14px;
            color: #555555;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Advanced To-Do List</h1>
        <div class="input-group">
            <input type="text" id="taskInput" placeholder="Enter a new task">
            <input type="datetime-local" id="taskTime">
            <button id="addTaskBtn">+</button>
        </div>
        <ul id="taskList"></ul>
    </div>
    <script>
        document.getElementById('addTaskBtn').addEventListener('click', addTask);
        document.getElementById('taskInput').addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                addTask();
            }
        });

        function addTask() {
            const taskInput = document.getElementById('taskInput');
            const taskTimeInput = document.getElementById('taskTime');
            const task = taskInput.value.trim();
            const taskTime = taskTimeInput.value;

            if (task === '') {
                alert('Please enter a task.');
                return;
            }

            const taskList = document.getElementById('taskList');
            const li = document.createElement('li');

            const taskText = document.createElement('span');
            taskText.textContent = task;

            const taskTimeDisplay = document.createElement('div');
            taskTimeDisplay.textContent = `Scheduled: ${taskTime ? new Date(taskTime).toLocaleString() : "No time set"}`;
            taskTimeDisplay.classList.add('task-time');

            const controls = document.createElement('div');
            controls.classList.add('task-controls');

            const deleteBtn = document.createElement('button');
            deleteBtn.textContent = 'Delete';
            deleteBtn.classList.add('deleteBtn');
            deleteBtn.addEventListener('click', (e) => {
                e.stopPropagation(); // Prevent the click event from propagating to the list item
                taskList.removeChild(li);
            });

            const editBtn = document.createElement('button');
            editBtn.textContent = 'Edit';
            editBtn.classList.add('editBtn');
            editBtn.addEventListener('click', (e) => {
                e.stopPropagation(); // Prevent the click event from propagating to the list item
                editTask(taskText, taskTimeDisplay, taskTimeInput, li);
            });

            controls.appendChild(editBtn);
            controls.appendChild(deleteBtn);

            li.appendChild(taskText);
            li.appendChild(taskTimeDisplay);
            li.appendChild(controls);

            taskList.appendChild(li);

            taskInput.value = '';
            taskTimeInput.value = '';

            li.addEventListener('click', () => {
                li.classList.toggle('completed');
            });
        }

        function editTask(taskText, taskTimeDisplay, taskTimeInput, listItem) {
            const newTask = prompt('Edit your task:', taskText.textContent);
            const newTime = prompt('Edit your time:', taskTimeDisplay.textContent.replace('Scheduled: ', ''));

            if (newTask !== null && newTask.trim() !== '') {
                taskText.textContent = newTask;
            }

            if (newTime !== null) {
                taskTimeDisplay.textContent = `Scheduled: ${newTime ? new Date(newTime).toLocaleString() : "No time set"}`;
            }
        }
    </script>
</body>
</html>
