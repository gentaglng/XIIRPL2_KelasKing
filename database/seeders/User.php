<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class User extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            ['nama' => 'l', 'role'=>'Pelajar', 'email' => 'l', 'password'=>'l'],
            ['nama' => 'j', 'role'=>'Pengajar', 'email' => 'j', 'password'=>'j']
        ];
        DB::table('user_kks')->insert($data);
    }
}
