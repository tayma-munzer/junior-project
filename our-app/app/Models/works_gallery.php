<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class works_gallery extends Model
{
    use HasFactory;
    protected $table = 'works_gallery';
    public $timestamps = false;
    protected $fillable = [
        's_id',
        'w_name',
        'w_desc',
    ];
}
