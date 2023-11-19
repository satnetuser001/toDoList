<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use App\Models\Task;

class TaskController extends Controller
{   
    public function __construct()
    {   
        //any method can be used only by authorized users
        $this->middleware('auth:sanctum');

        //Policy: only the owner of the task can view, edit, delete it.
        $this->middleware('can:isOwner,task')->only(['oneMy', 'update', 'status', 'destroy',]);
    }

    /**
     * Get all user tasks.
     *
     * @param  void
     * @return json tasks array
     */
    public function allMy(){
        $tasks = Auth::user()->tasks()->where('parent_id', '=', NULL)->latest()->get();
        return response()->json($tasks, 200);
    }

    /**
     * Get one user tasks.
     *
     * @param  task ID
     * @return json tasks | json tasks array
     */
    public function oneMy(Task $task){
        return response()->json($task, 200);
    }

    /**
     * Store a new task.
     *
     * @param  Request
     * @return json $task
     */
    public function store (Request $request){
        /*
        There should be validation here, but there is none in the test task.
        Example of some validation see in commit 90fbaf8
        */

        $task = $this->createTask($request->all());

        return response()->json($request->all(), 201);
    }

    protected function createTask($data)
    {
        $task = Auth::user()->tasks()->create([
            'priority' => $data['priority'],
            'title' => $data['title'],
            'description' => $data['description'],
        ]);

        /*
        It would probably be more correct to call the “children” method recursively 
        on the model, but I haven’t figured out how to do this.
        */

        if (isset($data['children'])) {
            foreach ($data['children'] as $childData) {
                $childTask = $this->createTask($childData);
                $childTask->parent_id = $task->id;
                $childTask->save();
            }
        }

        return $task;
    }

    /**
     * Update a task.
     *
     * @param  Request, Task
     * @return json $task
     */
    public function update (Request $request, Task $task){
        /*
        There should be validation here, but there is none in the test task.
        Example of some validation see in commit 90fbaf8
        */

        $task = $this->updateTask($request->all(), $task);

        return response()->json($request->all(), 200);
        //return response()->json($task, 200);
    }

    protected function updateTask($data, $task){

        //update the task
        $task->update([
            'priority' => $data['priority'],
            'title' => $data['title'],
            'description' => $data['description'],
        ]);

        //It would probably be more correct to call the “children” method recursively 
        //on the model, but I haven’t figured out how to do this.

        //update the children task
        if (isset($data['children'])) {
            foreach ($data['children'] as $childData) {
                //Bug. To change nested tasks, you must pass their ID.
                //The bug will be fixed using the “children” method of the Model.
                $childObj = Task::find($childData['id']);
                $this->updateTask($childData, $childObj);
            }
        }

        return $task;
    }

    public function status (Request $request, Task $task){

        //Check if any subtasks are not completed
        if ($request['status'] == 'done' and $task->children()->where('status', '!=', 'done')->exists()) {
            return response()->json(['error' => 'Cannot complete task until all subtasks are completed.'], 422);
        }

        // Check if the task is a subtask, and if its parent task is completed
        if ($request['status'] == 'todo' and $task->parent and $task->parent->status == 'done') {
            return response()->json(['error' => 'Cannot be todo until the parent task is completed.'], 422);
        }

        //Checking if the task has already been completed
        if ($request['status'] == 'done' and $task['status'] == 'done') {
            return response()->json(['error' => 'Task has already been completed.'], 422);
        }

        //Checking if the task has already been todo
        if ($request['status'] == 'todo' and $task['status'] == 'todo') {
            return response()->json(['error' => 'Task has already been todo.'], 422);
        }

        //If the status of a task changes
        if ($request['status'] == 'done' and $task['status'] != 'done') {
            $task->update([
                'status' => 'done',
                'completed_at' => date('Y-m-d H:i:s')
            ]);
        }
        elseif ($request['status'] == 'todo' and $task['status'] != 'todo') {
            $task->update([
                'status' => 'todo',
                'completed_at' => NULL
            ]);
        }

        return response()->json($task, 200);
    }

    /**
     * Delete user task.
     *
     * @param  task ID
     * @return json tasks | json tasks array
     */
    public function delete (Task $task){
        if ($task->status == "done") {
            return response()->json(['error' => 'A done task can\'t be deleted'], 405);
        }

        $task->delete();
        return response()->json($task, 200);
    }
}
