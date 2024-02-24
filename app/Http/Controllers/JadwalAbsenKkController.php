<?php

namespace App\Http\Controllers;

use App\Models\jadwal_absen_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class JadwalAbsenKkController extends Controller
{
    public function addJadwalAbsen(Request $req){
        try{
            $input = $req->all();
            $mulai = $req->input('mulai');
            $selesai = $req->input('selesai');
            $cm = Carbon::createFromFormat('H:i', $mulai);
            $cs = Carbon::createFromFormat('H:i', $selesai);
            if($cm->greaterThan($cs)){
                return response()->json(["message"=>"Format waktu salah", 'data'=>null]);
            }else{
                $data = jadwal_absen_kk::create($input);
                return response()->json(["message"=>"Jadwal absen berhasil dibuat", 'data'=>$data]);
            }
            
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
}