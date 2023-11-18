<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Task;

class TaskPolicy
{
    /**
     * Does the user own the task.
     * 
     * @param User, Task
     * @return bool
     */    
    public function isOwner(User $user, Task $task)
    {
        return $user->id == $task->user_id;
    }
}
