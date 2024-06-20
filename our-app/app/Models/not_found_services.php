<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class not_found_services extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'not_found_services';
    protected $fillable = [
        'service_desc',
        'u_id',
    ];
}
