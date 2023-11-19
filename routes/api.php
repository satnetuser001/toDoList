<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\TaskController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//User routes
Route::prefix('users')->group(function () {
    Route::post('/register', [UserController::class, 'register']);
    Route::patch('/regenerateToken', [UserController::class, 'regenerateToken']);
});

//Task routes
Route::prefix('tasks')->group(function () {
    Route::get('/allMy', [TaskController::class, 'allMy']);
    Route::get('/{task}', [TaskController::class, 'oneMy']);
    Route::post('/store', [TaskController::class, 'store']);
    Route::patch('/{task}', [TaskController::class, 'update']);
    Route::delete('/{task}', [TaskController::class, 'delete']);
});