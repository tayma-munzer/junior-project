<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class course extends Model
{
    use HasFactory;
    protected $table = 'courses';
    public $timestamps = false;
    protected $fillable = [
        'c_name',
        'c_desc',
        'c_price',
        'c_img',
        'u_id',
        'c_duration',
        'pre_requisite',
        'ct_id',
        'm_id',
    ];

    public function courses_type(){
        return 
        $this->belongsTo(courses_type::class,'ct_id','c_id');
    }
    public function media(){
        return 
        $this->belongsTo(media::class,'m_id','c_id');
    }
   
}
