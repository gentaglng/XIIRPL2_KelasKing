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
Route::post('/course/join', [CourseJoinKkController::class, 'joinCourse']);

Route::get('/course/pelajar/{id}', [CourseKkController::class, 'getCourseByStudent']);
Route::get('/materi/{course_id}', [MateriKkController::class, 'getMateri']);


Route::get('/absen/pelajar/{user_id}/{hari}/{tanggal}/{bulan}/{tahun}', [CourseJoinKkController::class, 'getAbsenStudent']);
Route::get('/absen/rekap/pelajar/{bulan}/{id}', [AbsenKkController::class, 'getRekapAbsenStudent']);
Route::post('/absen/today', [AbsenKkController::class, 'absenToday']);



Route::get('/course/pengajar/{id}', [CourseKkController::class, 'getCourseByTeacher']);
Route::get('/course/member/{course_id}', [CourseJoinKkController::class, 'getCourseMember']);
Route::post('/absen/add', [JadwalAbsenKkController::class, 'addJadwalAbsen']);
Route::post('/absen/add/late', [JadwalAbsenKkController::class, 'addJadwalAbsenLate']);
Route::get('/absen/pengajar/{id}', [AbsenKkController::class, 'getAbsenbyTeacher']);
Route::get('/absen/rekap/pengajar/{id}', [AbsenKkController::class, 'getRekapAbsenTeacher']);
Route::post('/materi/add', [MateriKkController::class, 'addMateri']);
