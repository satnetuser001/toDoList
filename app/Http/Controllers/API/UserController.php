<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\User;

class UserController extends Controller
{
    /**
     * Registering a new user and issuing a token to him.
     *
     * @param  Request
     * @return json $token | json $validator->errors()
     */
    public function register(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:4'],
            'program' => ['required', 'string', 'max:255'],
        ]); 

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 401);
        }
        
        $input = $request->all();
        //$input['password'] = bcrypt($input['password']);
        $input['password'] = Hash::make($input['password']);
        $user = User::create($input);   
        
        $token = $user->createToken($request->program)->plainTextToken;   
        
        return response()->json(['token' => $token], 201);
    }
}