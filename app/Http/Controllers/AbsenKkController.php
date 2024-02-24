<?php

namespace App\Http\Controllers;

use App\Models\absen_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AbsenKkController extends Controller
{
    public function absen(Request $req){
        try{
            $absen = absen_kk::where('course_id', $req->input('course_id'))
                            ->where('user_id', $req->input('user_id'))
                            ->where('tanggal', $req->input('tanggal'))
                            ->count();
            if($absen > 0){
                return response()->json(['message'=>'Kamu sudah melakukan absen']);
            }else{
                $input = $req->all();
                absen_kk::create($input);
                return response()->json(['message'=>'Absen berhasil']);
        }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getAbsenRekap(Request $req){
        try{
            $data = DB::table('absen_kks')
                            ->join('course_kks', 'course_kks.id', 'absen_kks.course_id')
                            ->select('course_kks.nama', 'absen_kks.keterangan', 'absen_kks.hari', 'absen_kks.tanggal')
                            ->where('absen_kks.user_id', $req->input('user_id'))
                            ->where('absen_kks.bulan', $req->input('bulan'))
                            ->get();
            $count = $data->count();
            if($count > 0){
                return response()->json(['message' =>'Data berhasil didapatkan', 'data'=>$data]);
            }else{
                return response()->json(['message' =>'Kamu belum melakukan absen bulan ini']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
}
