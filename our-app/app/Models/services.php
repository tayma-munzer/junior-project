<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class services extends Model
{
    use HasFactory;
    protected $table = 'services';
    protected $primaryKey = 's_id';
    protected $fillable = [
        'u_id',
        's_name',
        's_price',
        'num_of_buyers',
        's_desc',
        's_duration',
        'st_id',
        'discount',
        'status',
        's_img',
        's_video',
    ];


    public function complaints()
    {
        return $this->morphMany(Complaint::class, 'complainable');
    }
    public function ratings(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(rates_reviews::class, 'ratable');
    }
    public function user(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'u_id');
    }
}
