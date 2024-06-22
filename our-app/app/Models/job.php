<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class job extends Model
{
    use HasFactory;
    protected $table = 'jobs';
    protected $primaryKey = 'j_id';
    public $timestamps = false;
    protected $fillable = [
        'u_id',
        'j_name',
        'j_desc',
        'j_sal',
        'j_req',
        // 'is_accepted',
    ];

    public function complaints(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(Complaint::class, 'complainable');
    }
    public function ratings(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(rates_reviews::class, 'ratable');
    }
}
