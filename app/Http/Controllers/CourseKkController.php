<?php

namespace App\Http\Controllers;

use App\Models\course_kk;
use App\Models\user_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CourseKkController extends Controller
{
    public function addCourse(Request $req){
        try{
            $course = course_kk::where('instructor_id', $req->input('instructor_id'))
                                ->where('nama', $req->input('nama'))
                                ->count();
            if($course > 0){
                return response()->json(['message'=>'Course sudah ada']);
            }else{
                $input = $req->all();
                $course = course_kk::create($input);
                return response()->json(['message'=>'Course berhasil dibuat', 'data'=>$course]);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getCourseByStudent($id){
        try{
            $course = DB::table('course_kks')->join('course_join_kks', 'course_kks.id', 'course_join_kks.course_id')
                                            ->join('user_kks', 'user_kks.id', 'course_kks.instructor_id')
                                            ->select('course_join_kks.id','course_kks.nama', 'course_kks.instructor_id', 'course_kks.absen', 'course_kks.nilai', 'course_join_kks.course_id', 'course_join_kks.user_id', 'user_kks.nama AS namaguru')
                                            ->where('course_join_kks.user_id', $id)
                                            ->get();
            $count = $course->count(); 
            if($count > 0){
                return response()->json(['message'=>'Course berhasil didapatkan', 'data'=>$course]);
            }else{
                return response()->json(['message'=>'Kamu belum bergabung dengan course']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getCourseByTeacher($id){
        try{
            $course = DB::table('course_kks')
                                ->leftJoin('course_join_kks', 'course_kks.id', 'course_join_kks.course_id')
                                ->leftJoin('user_kks', 'user_kks.id', 'course_kks.instructor_id')
                                ->select('course_join_kks.id', 'course_kks.nama', 'course_kks.instructor_id', 'course_kks.absen', 'course_kks.nilai', 'course_kks.id AS course_id', 'course_join_kks.user_id', 'user_kks.nama AS namaguru')
                                ->where('course_kks.instructor_id', $id)
                                ->get();
            $count = $course->count(); 
            if($count > 0){
                return response()->json(['message'=>'Course berhasil didapatkan', 'data'=>$course]);
            }else{
                return response()->json(['message'=>'Kamu tidak memiliki course']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
}
