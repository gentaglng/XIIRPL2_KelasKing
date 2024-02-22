<?php

namespace App\Http\Controllers;

use App\Models\absen_kk;
use Illuminate\Http\Request;

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
}
