<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class job extends Model
{
    use HasFactory;
    protected $table = 'jobs';
    protected $primaryKey = 'j_id';
    protected $fillable = [
        'u_id',
        'j_title',
        'j_desc',
        'j_req',
        'j_min_sal',
        'j_max_sal',
        'j_min_age',
        'j_max_age',
        'education',
        'num_of_exp_years',
        'jt_id',
        'is_accepted',
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
