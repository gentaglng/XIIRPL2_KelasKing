<?php

namespace App\Http\Controllers;

use App\Models\materi_kk;
use Illuminate\Http\Request;

class MateriKkController extends Controller
{
    public function addMateri(Request $req){
        try{
            $judul = materi_kk::where('judul', $req->input('judul'))
                                ->where('course_id', $req->input('course_id'))
                                ->count();
            if($req->input('role') == 'Pelajar'){
                return response()->json(['message'=>'Kamu bukan pengajar']);
            }else if($judul > 0){
                return response()->json(['message'=>'Materi sudah ada']);
            }
            else{
                $input = $req->all();
                materi_kk::create($input);
                return response()->json(['message'=>'Materi berhasil ditambahkan']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
}
