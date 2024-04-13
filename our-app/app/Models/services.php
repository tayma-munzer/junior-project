<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class services extends Model
{
    use HasFactory;
    protected $table = 'services';
    public $timestamps = false;
    protected $fillable = [
        'u_id',
        's_name',
        's_price',
        'num_of_buyers',
        's_desc',
        's_duration',
        't_id',
        'discount',
        'status',
        's_img',
        's_video',
    ];
}
