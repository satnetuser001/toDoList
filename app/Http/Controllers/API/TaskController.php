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
        $this->middleware('can:isOwner,task')->only(['oneMy', 'destroy',]);
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
     * @return json $token | json $validator->errors()
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
            'status' => $data['status'],
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
     * Delete user task.
     *
     * @param  task ID
     * @return json tasks | json tasks array
     */
    public function delete(Task $task){
        if ($task->status == "done") {
            return response()->json(['error' => 'A done task can\'t be deleted'], 405);
        }

        $task->delete();
        return response()->json($task, 200);
    }
}
