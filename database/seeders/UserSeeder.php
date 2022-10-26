<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run()
    {
//        User::factory(10000)->create();

        $faker = \Faker\Factory::create();
        $data = [];

        for ($i = 0; $i < 100000; $i++) {
            $data[] = [
                'name'              => $faker->name(),
                'email'             => $faker->unique()->safeEmail(),
                'field1'              => $faker->text(),
                'field2'              => $faker->text(),
                'field3'              => $faker->text(),
                'field4'              => $faker->text(),
                'field5'              => $faker->text(),
                'field6'              => $faker->text(),
                'field7'              => $faker->text(),
                'field8'              => $faker->text(),
                'field9'              => $faker->text(),
                'field10'              => $faker->text(),

                'password'          => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
            ];
        }

        $chunks = array_chunk($data, 5000);

        foreach ($chunks as $chunk) {
            User::insert($chunk);
        }
    }
}
