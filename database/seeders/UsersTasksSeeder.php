<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UsersTasksSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        /*settings*/
        $usersCount = 2;
        $tasksFirstLevelCount = 5;

        /*users*/
        for ($i=1; $i <= $usersCount; $i++) {            
            $objUser = User::create([
                'name' => 'apiUser' . $i,
                'email' => 'apiUser' . $i . '@gmail.com',
                'password' => Hash::make(1077),
            ]);

            /*tasks*/
            for ($j=1; $j <= $tasksFirstLevelCount; $j++) {
                $task1 = $objUser->tasks()->create([
                    'priority' => rand(1, 5),
                    'title' => "Title $j/1",
                    'description' => Str::random(rand(5, 10)),
                ]);
                $task11 = $objUser->tasks()->create([
                    'priority' => rand(1, 5),
                    'title' => "Title $j/1/1",
                    'description' => Str::random(rand(5, 10)),
                    'parent_id' => $task1->id,
                ]);
                $task12 = $objUser->tasks()->create([
                    'priority' => rand(1, 5),
                    'title' => "Title $j/1/2",
                    'description' => Str::random(rand(5, 10)),
                    'parent_id' => $task1->id,
                ]);
                $task121 = $objUser->tasks()->create([
                    'priority' => rand(1, 5),
                    'title' => "Title $j/1/2/1",
                    'description' => Str::random(rand(5, 10)),
                    'parent_id' => $task12->id,
                ]);
            }
        }
    }
}
