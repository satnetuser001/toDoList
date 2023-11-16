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

        //validating the request
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:4'],
            'program' => ['required', 'string', 'max:255'],
        ]); 

        //if validation fails, return json response with an error
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 401);
        }
        
        //Hash the password and save the user in the database
        $input = $request->all();
        $input['password'] = Hash::make($input['password']);
        $user = User::create($input);   
        
        //generate a token and save it in the database
        $token = $user->createToken($request->program)->plainTextToken;   
        
        //return jason response with a token to the user
        return response()->json(['token' => $token], 201);
    }

    /**
     * Regenerate the user token and issue it to him.
     *
     * @param  Request
     * @return json $token | json $validator->errors()  | json "user data didn't match"
     */
    public function regenerateToken(Request $request){

        //validating the request
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255'],
            'password' => ['required', 'string', 'min:4'],
            'program' => ['required', 'string', 'max:255'],
        ]); 

        //if validation fails, return json response with an error
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 401);
        }

        //find the user in the database by email
        $user = User::where('email', $request->email)->first();

        //check if the user is found and if the password matches
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['error' => 'The provided credentials are incorrect.'], 401);
        }

        //delete the old user token
        $user->tokens()->delete();

        //generate a new token and save it in the database
        $newToken = $user->createToken($request->program)->plainTextToken;   
        
        //return jason response with a new token to the user
        return response()->json(['newToken' => $newToken], 200);
    }
}