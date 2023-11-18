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

        //it is be a Policy
        //$this->middleware('can:isOwner,task')->only(['one', 'update', 'destroy']);
    }

    /**
     * Store a new task.
     *
     * @param  Request
     * @return json $token | json $validator->errors()
     */
    public function store (Request $request){
        /*
        //validating the request
        $validator = Validator::make($request->all(), [
            'status' => ['required', 'in:todo,done'],
            'priority' => ['required', 'in:1,2,3,4,5'],
            'title' => ['required', 'string', 'max:20000'],
            'description' => ['nullable', 'string', 'max:5500000'],
        ]); 

        //if validation fails, return json response with an error
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 401);
        }
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
}
