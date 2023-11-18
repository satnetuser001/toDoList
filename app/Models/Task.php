<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class Task extends Model
{
    use HasFactory;
    
    /**
     * The relationships that should always be loaded.
     *
     * @var array
     */
    protected $with = ['children'];

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = ['user_id', 'status', 'priority', 'title', 'description', 'parent_id', 'completed_at'];

    /**
     * Get user of this task
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get parent of this task
     */
    public function parent()
    {
        return $this->belongsTo(Task::class, 'parent_id');
    }

    /**
     * Get children of this task
     */
    public function children()
    {
        return $this->hasMany(Task::class, 'parent_id');
    }
}
