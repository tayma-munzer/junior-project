<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class course extends Model
{
    use HasFactory;
    protected $table = 'courses';
    protected  $primaryKey = 'c_id';
    public $timestamps = false;
    protected $fillable = [
        'c_name',
        'c_desc',
        'c_price',
        'c_img',
        'u_id',
        'c_duration',
        'pre_requisite',
        'num_of_free_videos',
        'ct_id',
        'is_accepted',
    ];

    public function courses_type(){
        return
        $this->belongsTo(courses_type::class,'ct_id','c_id');
    }


    public function complaints()
    {
        return $this->morphMany(Complaint::class, 'complainable');
    }

    public function ratings(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(rates_reviews::class, 'ratable');
    }

}
