<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class service_enrollment extends Model
{
    use HasFactory;
    protected $table = 'service_enrollments';
    protected $fillable = [
        's_id',
        'u_id',
        'status'
    ];
}
