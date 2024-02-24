<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class Course extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            ['id' => Str::uuid(), 'nama' => 'c1', 'instructor_id'=>'2', 'nilai' => 'no', 'absen'=>'yes'],
            ['id' => Str::uuid(), 'nama' => 'c2', 'instructor_id'=>'2', 'nilai' => 'no', 'absen'=>'yes'],
            ['id' => Str::uuid(), 'nama' => 'c3', 'instructor_id'=>'2', 'nilai' => 'no', 'absen'=>'yes'],
            ['id' => Str::uuid(), 'nama' => 'c4', 'instructor_id'=>'2', 'nilai' => 'no', 'absen'=>'yes'],
        ];
        DB::table('course_kks')->insert($data);
    }
}
