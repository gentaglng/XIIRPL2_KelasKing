<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMateriKksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('materi_kks', function (Blueprint $table) {
            $table->id();
            $table->string('course_id');
            $table->string('judul');
            $table->string('sub_judul_1')->default('no');
            $table->string('link_materi_1')->default('no');
            $table->text('deskripsi_1')->default('no');
            $table->string('sub_judul_2')->default('no');
            $table->string('link_materi_2')->default('no');
            $table->text('deskripsi_2')->default('no');
            $table->string('sub_judul_3')->default('no');
            $table->string('link_materi_3')->default('no');
            $table->text('deskripsi_3')->default('no');
            $table->string('sub_judul_4')->default('no');
            $table->string('link_materi_4')->default('no');
            $table->text('deskripsi_4')->default('no');
            $table->string('sub_judul_5')->default('no');
            $table->string('link_materi_5')->default('no');
            $table->text('deskripsi_5')->default('no');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('materi_kks');
    }
}
