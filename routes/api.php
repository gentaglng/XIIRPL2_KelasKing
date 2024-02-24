<?php

use App\Http\Controllers\AbsenKkController;
use App\Http\Controllers\CourseJoinKkController;
use App\Http\Controllers\CourseKkController;
use App\Http\Controllers\JadwalAbsenKkController;
use App\Http\Controllers\MateriKkController;
use App\Http\Controllers\UserKkController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('/register', [UserKkController::class, 'register']);
Route::post('/login', [UserKkController::class, 'login']);

Route::post('/course/add', [CourseKkController::class, 'addCourse']);
Route::post('/course/absen/add', [JadwalAbsenKkController::class, 'addJadwalAbsen']);
Route::post('/course/join', [CourseJoinKkController::class, 'joinCourse']);
Route::get('/course/pelajar/{id}', [CourseKkController::class, 'getCourseByUser']);
Route::get('/course/pengajar/{id}', [CourseKkController::class, 'getCourseByInstuctor']);
Route::post('/course/absen/today', [CourseJoinKkController::class, 'getAbsenToday']);
Route::post('/course/absen', [AbsenKkController::class, 'absen']);
Route::post('/course/absen/rekap', [AbsenKkController::class, 'getAbsenRekap']);

//Route::post('/materi/add', [MateriKkController::class, 'addMateri']);

