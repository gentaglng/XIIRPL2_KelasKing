<?php

namespace App\Http\Controllers;

use App\Models\absen_kk;
use App\Models\course_join_kk;
use App\Models\course_kk;
use App\Models\user_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CourseJoinKkController extends Controller
{
    public function joinCourse(Request $req){
        try{
            $course = course_kk::where('id', $req->input('course_id'))->first();
            $user = user_kk::where('id', $req->input('user_id'))->first();
            if($course == null){
                return response()->json(['message'=>'Course tidak ditemukan']);
            } else if($user->role == "Pengajar"){
                return response()->json(['message'=>'Kamu bukan pelajar']);
            } else {
                $cek = course_join_kk::where('course_id', $course->id)
                                    ->where('user_id', $user->id)
                                    ->count();
                if($cek > 0){
                    return response()->json(['message'=>'Kamu sudah bergabung']);
                } else {
                    $input = $req->all();
                    $data = course_join_kk::create($input);
                    return response()->json(['message'=>'Berhasil bergabung course', 'data'=>$data]);
                }
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getAbsenToday(Request $req){
        try{
            $absentoday = DB::table('course_join_kks')
                            ->join('jadwal_absen_kks', 'course_join_kks.course_id', 'jadwal_absen_kks.course_id')
                            ->where('course_join_kks.user_id', $req->input('user_id'))
                            ->where('jadwal_absen_kks.hari', 'LIKE', '%' . $req->input('hari') . '%')
                            ->get();
            $absentodaycount = $absentoday->count();
            if($absentodaycount > 0){
                $sudahabsen = absen_kk::where('user_id', $req->input('user_id'))
                            ->where('tanggal', $req->input('tanggal'))
                            ->where('bulan', $req->input('bulan'))
                            ->where('tahun', $req->input('tahun'))
                            ->get();

                $belumabsen = [];
                foreach ($absentoday as $item){
                    $found = false;
                    foreach ($sudahabsen as $absen){
                        if($item->course_id === $absen->course_id){
                            $found = true;
                            break;
                        }
                    }
                    if(!$found){
                        $belumabsen[] = $item;
                    }
                }
                $responseData = [];
                if (empty($belumabsen)) {
                    $responseData['message'] = 'Kamu sudah absen semua';
                    $responseData['data'] = $sudahabsen;
                }else if(empty($sudahabsen)){
                    $responseData['message'] = 'Kamu belum absen semua';
                    $responseData['data'] = $belumabsen;
                }else{
                    $responseData['message'] = 'Data absen kamu';
                    $responseData['sudahabsen'] = $sudahabsen;
                    $responseData['belumabsen'] = $belumabsen;
                }
                return response()->json($responseData);
            }else{
                return response()->json(['message'=>'Tidak ada absen hari ini']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
}
